//
//  Encodable+JSON.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import Foundation

extension Encodable {
    func asJSON<T: Collection>(encoder: JSONEncoder = JSONEncoder()) throws -> T {
        let encodedJSONData = try encoder.encode(self)
        guard let rawJSON = try JSONSerialization.jsonObject(with: encodedJSONData) as? T
        else { throw JSONSerialization.Error.serializationFailed }
        return rawJSON
    }
}

extension JSONSerialization {
    enum Error: Swift.Error {
        case serializationFailed
    }
}
