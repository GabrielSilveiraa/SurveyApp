//
//  GetQuestionsEndpoint.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import GMSNewtorkLayer
import Foundation

struct GetQuestionsEndpoint: EndPointType {
    var baseURL: URL {
        .init(string: "https://xm-assignment.web.app")!
    }

    var path: String {
        "questions"
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var encoding: ParameterEncoding?
    var parameters: [String : AnyObject]?
    var headers: [String : String]?
}
