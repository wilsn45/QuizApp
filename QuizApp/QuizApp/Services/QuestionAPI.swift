//
//  QuestionService.swift
//  QuizApp
//
//  Created by Wilson Shakya on 01/05/21.
//

import Foundation

struct QuestionAPI: APIHandler {
    
    func makeRequest() -> URLRequest? {
        let urlString =  APIPath().gallary
        if var url = URL(string: urlString) {
           var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> QuestionModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
