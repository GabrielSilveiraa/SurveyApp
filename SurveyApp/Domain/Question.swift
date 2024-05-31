//
//  Question.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import Foundation

struct Question: Equatable {
    var id: Int
    var text: String
    var answer: String = ""
    var isSubmitted: Bool = false
    var submissionFailed: Bool = false
}
