//
//  SurveyReducer.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 29/5/24.
//

import ComposableArchitecture
import Combine
import SwiftUI

final class SurveyReducer: Reducer {
    struct State: Equatable {
        var questions: [Question] = []
        var currentQuestionIndex: Int = -1
        var isLoading: Bool = false
        var error: SurveyError?
        var bannerPresentation: BannerPresentation = .hide

        var currentQuestion: Question? {
            guard !questions.isEmpty, currentQuestionIndex > -1 else { return nil }
            return questions[currentQuestionIndex]
        }

        var questionNumber: Int {
            currentQuestionIndex + 1
        }

        var totalQuestions: Int {
            questions.count
        }

        var questionsSubmitted: Int {
            questions.filter { $0.isSubmitted }.count
        }
    }

    enum Action: Equatable {
        case loadQuestions
        case questionsLoaded(Result<[Question], SurveyError>)
        case submitAnswer
        case answerSubmissionResponse(Bool)
        case previousQuestion
        case nextQuestion
        case updateAnswer(String)
        case hideBanner
        case retrySubmission
    }

    enum SurveyError: Error, Equatable {
        case networkError
    }

    enum BannerPresentation: Equatable {
        case show(BannerType)
        case hide
    }

    private let effects: Effects

    init(effects: Effects) {
        self.effects = effects
    }

    static func buildDefault() -> Self {
        .init(effects: .buildDefault())
    }

    var body: some ReducerOf<SurveyReducer> {
        Reduce { [weak self] state, action in
            guard let self = self else { return .none }
            switch action {
            case .loadQuestions:
                state.isLoading = true
                return effects.loadQuestions()

            case .questionsLoaded(let result):
                state.isLoading = false
                switch result {
                case let .success(questions):
                    state.currentQuestionIndex = 0
                    state.questions = questions
                case let .failure(error):
                    state.error = error
                }

            case .submitAnswer:
                guard let answer = state.currentQuestion else { return .none }
                return effects.updateAnswer(answer)

            case .answerSubmissionResponse(let result):
                if result {
                    state.bannerPresentation = .show(.success)
                    state.questions[state.currentQuestionIndex].isSubmitted = true
                } else {
                    state.bannerPresentation = .show(.error)
                    state.questions[state.currentQuestionIndex].submissionFailed = true
                }
                return effects.hideBannerAfter2Seconds()

            case .previousQuestion:
                if state.currentQuestionIndex > 0 {
                    state.currentQuestionIndex -= 1
                    state.bannerPresentation = .hide
                }

            case .nextQuestion:
                if state.currentQuestionIndex < state.questions.count - 1 {
                    state.currentQuestionIndex += 1
                    state.bannerPresentation = .hide
                }

            case .updateAnswer(let answer):
                guard !state.questions.isEmpty else { return .none }
                state.questions[state.currentQuestionIndex].answer = answer

            case .hideBanner:
                state.bannerPresentation = .hide

            case .retrySubmission:
                guard let currentQuestion = state.currentQuestion else { return .none }
                state.bannerPresentation = .hide
                return effects.updateAnswer(currentQuestion)
            }

            return .none
        }
    }
}

extension SurveyReducer {
    struct Effects {
        private let getQuestions: GetQuestions.UseCase
        private let submitAnswer: SubmitAnswer.UseCase
        private let scheduler: AnySchedulerOf<DispatchQueue>

        init(getQuestions: @escaping GetQuestions.UseCase,
             submitAnswer: @escaping SubmitAnswer.UseCase,
             scheduler: AnySchedulerOf<DispatchQueue>) {
            self.getQuestions = getQuestions
            self.submitAnswer = submitAnswer
            self.scheduler = scheduler
        }

        static func buildDefault() -> Self {
            .init(getQuestions: GetQuestions.buildDefault().execute,
                  submitAnswer: SubmitAnswer.buildDefault().execute,
                  scheduler: .main)
        }

        func loadQuestions() -> Effect<Action> {
            .publisher {
                getQuestions()
                    .receive(on: scheduler)
                    .map { .questionsLoaded(.success($0)) }
                    .catch { _ in Just(Action.questionsLoaded(.failure(.networkError))) }
            }
        }

        func updateAnswer(_ answer: Question) -> Effect<Action> {
            .publisher {
                submitAnswer(answer)
                    .receive(on: scheduler)
                    .map { .answerSubmissionResponse($0) }
            }
        }

        func hideBannerAfter2Seconds() -> Effect<Action> {
            .publisher {
                Just(())
                    .delay(for: .seconds(2), scheduler: scheduler)
                    .receive(on: scheduler)
                    .map { .hideBanner }
            }
        }
    }
}

