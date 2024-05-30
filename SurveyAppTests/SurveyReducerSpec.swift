//
//  SurveyReducerSpec.swift
//  SurveyAppTests
//
//  Created by Gabriel Miranda on 30/5/24.
//

import Quick
import Nimble
import ComposableArchitecture
import XCTest
import Combine
@testable import SurveyApp

class SurveyReducerSpec: AsyncSpec {
    override static func spec() {
        describe("\(SurveyReducer.self)") {
            var store: TestStore<SurveyReducer.State, SurveyReducer.Action>!
            var scheduler: TestSchedulerOf<DispatchQueue>!
            var effects: SurveyReducer.Effects!

            beforeEach { @MainActor in
                setEffects()
            }

            context("when loading questions") {
                it("should set loading state and then load questions successfully") { @MainActor in
                    await store.send(.loadQuestions) {
                        $0.isLoading = true
                    }
                    await scheduler.run()
                    //                    store.receive(.questionLoaded)
                    await store.receive(.questionsLoaded(.success([
                        Question(id: 1, text: "Question 1"),
                        Question(id: 2, text: "Question 2")
                    ]))) {
                        $0.isLoading = false
                        $0.questions = [
                            Question(id: 1, text: "Question 1"),
                            Question(id: 2, text: "Question 2")
                        ]
                        $0.currentQuestionIndex = 0
                    }
                }
            }

            it("should handle error when loading questions fails") { @MainActor in
                setEffects(getQuestions: {
                    Fail(error: SurveyReducer.SurveyError.networkError)
                        .eraseToAnyPublisher()
                })
                await store.send(.loadQuestions) {
                    $0.isLoading = true
                }
                await scheduler.run()
                await store.receive(.questionsLoaded(.failure(.networkError))) {
                    $0.isLoading = false
                    $0.error = .networkError
                }
            }

            context("when submitting an answer") {
                it("should submit the answer successfully") { @MainActor in
                    setEffects(initialState: .init(questions: [.init(id: 1, text: "Question 1")], currentQuestionIndex: 0))
                    await store.send(.submitAnswer)
                    await scheduler.run()
                    await store.receive(.answerSubmissionResponse(true)) {
                        $0.bannerPresentation = .show(.success)
                        $0.questions[0].isSubmitted = true
                    }
                }

                it("should handle submission failure") { @MainActor in
                    setEffects(submitAnswer: { _ in
                        Just(false)
                            .eraseToAnyPublisher()
                    }, initialState: .init(questions: [.init(id: 1, text: "Question 1")], currentQuestionIndex: 0))

                    await store.send(.submitAnswer)
                    await scheduler.run()
                    await store.receive(.answerSubmissionResponse(false)) {
                        $0.bannerPresentation = .show(.error)
                        $0.questions[0].submissionFailed = true
                    }
                }
            }

            context("when navigating questions") {
                beforeEach { @MainActor in
                    setEffects(initialState: SurveyReducer.State(questions: [
                        Question(id: 1, text: "Question 1"),
                        Question(id: 2, text: "Question 2")
                    ], currentQuestionIndex: 0))
                }

                it("should go to the next question") { @MainActor in
                    await store.send(.nextQuestion) {
                        $0.currentQuestionIndex = 1
                    }
                }

                it("should go to the previous question") { @MainActor in
                    await store.send(.nextQuestion) {
                        $0.currentQuestionIndex = 1
                    }
                    await store.send(.previousQuestion) {
                        $0.currentQuestionIndex = 0
                    }
                }
            }

            context("when updating the answer") {
                it("should update the answer for the current question") { @MainActor in
                    setEffects(initialState: .init(questions: [Question(id: 1, text: "Question 1")], currentQuestionIndex: 0))
                    await store.send(.updateAnswer("New Answer")) {
                        $0.questions[0].answer = "New Answer"
                    }
                }
            }

            context("when handling banner presentation") {
                it("should hide the banner") { @MainActor in
                    setEffects(initialState: .init(bannerPresentation: .show(.success)))
                    await store.send(.hideBanner) {
                        $0.bannerPresentation = .hide
                    }
                }

                it("should retry submission when banner is shown") { @MainActor in
                    setEffects(initialState: .init(questions: [Question(id: 1, text: "Question 1", answer: "Answer", submissionFailed: true)], currentQuestionIndex: 0))
                    await store.send(.retrySubmission)
                    await scheduler.run()
                    await store.receive(.answerSubmissionResponse(true)) {
                        $0.bannerPresentation = .show(.success)
                        $0.questions[0].isSubmitted = true
                    }
                }
            }

            func setEffects(
                getQuestions: @escaping GetQuestions.UseCase = {
                    Just([Question(id: 1, text: "Question 1"),
                          Question(id: 2, text: "Question 2")])
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                },
                submitAnswer: @escaping SubmitAnswer.UseCase = { _ in
                    Just(true)
                        .eraseToAnyPublisher()
                }, 
                initialState: SurveyReducer.State = .init()) {
                scheduler = DispatchQueue.test
                effects = .init(
                    getQuestions: getQuestions,
                    submitAnswer: submitAnswer,
                    scheduler: scheduler.eraseToAnyScheduler())
                store = TestStore(initialState: initialState,
                                  reducer: {
                    SurveyReducer(effects: effects)
                })
            }
        }
    }
}
