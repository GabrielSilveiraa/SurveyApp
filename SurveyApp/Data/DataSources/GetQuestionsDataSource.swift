//
//  GetQuestionsDataSource.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import Foundation
import GMSNewtorkLayer
import Combine

protocol GetQuestionsDataSourcing {
    func getQuestions() -> Future<[QuestionDataModel], Error>
}

final class GetQuestionsDataSource: GetQuestionsDataSourcing {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    static func buildDefault() -> Self {
        .init(networkManager: NetworkManager(loggingEnabled: true))
    }

    func getQuestions() -> Future<[QuestionDataModel], Error> {
        Future { observer in
            let endpoint = GetQuestionsEndpoint()
            self.networkManager.request(endpoint) { (response: Result<[QuestionDataModel], Error>) in
                do {
                    let questions = try response.get()
                    observer(.success(questions))
                } catch {
                    observer(.failure(error))
                }
            }
        }
    }
}
