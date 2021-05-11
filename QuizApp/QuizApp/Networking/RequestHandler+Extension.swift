//
//  RequestHandler+Extension.swift
//  QuizApp
//
//  Created by Wilson Shakya on 01/05/21.
//

import Foundation

extension RequestHandler {
    
    func setQueryParams(parameters:[String: Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }
    
}
