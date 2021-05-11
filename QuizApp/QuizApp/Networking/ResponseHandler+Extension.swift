//
//  ResponseHandler+Extension.swift
//  QuizApp
//
//  Created by Wilson Shakya on 01/05/21.
//

import Foundation

struct ServiceError: Error,Codable {
    let httpStatus: Int
    let message: String
}

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch  {
            print(error.localizedDescription)
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}
