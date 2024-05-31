//
//  SurveyView_SnapshotPreview.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import SwiftUI
import PreviewSnapshots
import ComposableArchitecture
import Combine

extension SurveyView_Previews {
    static var snapshots: PreviewSnapshots<PreviewConfiguration<SurveyReducer.State>> {
        PreviewSnapshots(
            configurations: [
                .init(name: "Default SurveyView", state: .init(state: .init(questions: self.questions, 
                                                                            currentQuestionIndex: 0))),
                .init(name: "Dark SurveyView", state: .init(colorScheme: .dark, state: .init(questions: self.questions,
                                                                                             currentQuestionIndex: 0))),
                .init(name: "xxxLarge SurveyView", state: .init(dynamicTypeSize: .accessibility5,
                                                                state: .init(questions: self.questions, 
                                                                             currentQuestionIndex: 0)))
            ],
            configure: { configuration in
                NavigationStack {
                    SurveyView.init(store: Store(initialState: configuration.state ?? .init(),
                                                 reducer: { SurveyReducer.init(effects: self.previewEffects) }))
                }
                .environment(\.colorScheme, configuration.colorScheme)
                .environment(\.dynamicTypeSize, configuration.dynamicTypeSize)
            }
        )
    }

    static let previewEffects: SurveyReducer.Effects = .init(
        getQuestions: {
            Just(questions)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        },
        submitAnswer: { _ in
            Just(true)
                .eraseToAnyPublisher()
        },
        scheduler: .main
    )

    static let questions = [Question(id: 1,
                                     text: "Is it a good snapshot test?",
                                     answer: "Yes!",
                                     isSubmitted: true),
                            Question(id: 2,
                                     text: "Is it another good snapshot test?")]
}
