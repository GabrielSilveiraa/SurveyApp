//
//  SubmitAnswer.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import Foundation
import Combine

final class SubmitAnswer {
    typealias UseCase = (Question) -> AnyPublisher<Bool, Never>

    private let dataSource: SubmitAnswerDataSourcing

    static func buildDefault() -> Self {
        self.init(dataSource: SubmitAnswerDataSource.buildDefault())
    }

    init(dataSource: SubmitAnswerDataSourcing) {
        self.dataSource = dataSource
    }

    func execute(_ question: Question) -> AnyPublisher<Bool, Never> {
        let dataModel = AnswerDataModel(id: question.id,
                                        answer: question.answer)
        return dataSource.submitAnswer(requestDataModel: dataModel)
            .map { true }
            .catch { _ in Just(false) }
            .eraseToAnyPublisher()
    }
}


