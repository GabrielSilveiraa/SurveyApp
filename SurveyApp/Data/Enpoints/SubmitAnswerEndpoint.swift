//
//  SubmitAnswerEndpoint.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import GMSNewtorkLayer
import Foundation

struct SubmitAnswerEndpoint {
    let answer: AnswerDataModel
}

extension SubmitAnswerEndpoint: EndPointType {
    var baseURL: URL {
        .init(string: "https://xm-assignment.web.app")!
    }

    var path: String {
        "question/submit"
    }

    var httpMethod: HTTPMethod {
        .post
    }

    var encoding: ParameterEncoding? {
        .jsonEncoding
    }

    var parameters: [String : AnyObject]? {
        try? answer.asJSON()
    }

    var headers: [String : String]? {
        nil
    }
}

