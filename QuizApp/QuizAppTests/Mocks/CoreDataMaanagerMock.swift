//
//  CoreDataMaanagerMock.swift
//  QuizAppTests
//
//  Created by Wilson Shakya on 04/05/21.
//

import Foundation
@testable import QuizApp

class CoreDataMaanagerMock : CoreDataManagerType {
    func recordAnswer(answer: Answer) {
        return
    }
    
    func getAnswers() -> [Answer] {
        let ans = Answer(question : Question(id :1, type : .Text, question : "Text Question", contentUrl : "", options : ["1","2","3"], correctAnswers : ["1"]), submitedAnswers : [])
        return [ans]
    }

}
