//
//  GetQuestionsDataSource.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import Foundation
import GMSNewtorkLayer
import Combine

protocol SubmitAnswerDataSourcing {
    func submitAnswer(requestDataModel: AnswerDataModel) -> Future<Void, Error>
}

final class SubmitAnswerDataSource: SubmitAnswerDataSourcing {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    static func buildDefault() -> Self {
        .init(networkManager: NetworkManager(loggingEnabled: true))
    }

    func submitAnswer(requestDataModel: AnswerDataModel) -> Future<Void, Error> {
        Future { observer in
            let endpoint = SubmitAnswerEndpoint(answer: requestDataModel)
            self.networkManager.request(endpoint) { (response: Result<EmptyResponse, Error>) in
                switch response {
                case .success:
                    observer(.success(()))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
        }
    }
}
