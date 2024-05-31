//
//  GetQuestions.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import Foundation
import Combine

final class GetQuestions {
    typealias UseCase = () -> AnyPublisher<[Question], Error>

    private let dataSource: GetQuestionsDataSourcing

    static func buildDefault() -> Self {
        self.init(dataSource: GetQuestionsDataSource.buildDefault())
    }

    init(dataSource: GetQuestionsDataSourcing) {
        self.dataSource = dataSource
    }

    func execute() -> AnyPublisher<[Question], Error> {
        dataSource.getQuestions()
            .map { $0.map { .init(id: $0.id, text: $0.question) } }
            .eraseToAnyPublisher()
    }
}

