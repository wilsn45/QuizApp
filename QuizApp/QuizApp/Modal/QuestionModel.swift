//
//  ResponseModel.swift
//  QuizApp
//
//  Created by Wilson Shakya on 01/05/21.
//

import Foundation

public enum QuestionType: String, Codable {
    case Text = "text"
    case Image
    case Audio
    case Video
}

struct QuestionModel: Codable {
   
    var success: Bool
    var data: [Question]
    
    private enum CodingKeys: String, CodingKey {
        case success
        case data
    }
}

struct Question: Codable {

    var id: Int = 0
    var type: QuestionType = .Text
    var contentUrl: String = ""
    var question: String = ""
    var options: [String] = []
    var correctAnswers: [String] = []
    
    init(id :Int, type : QuestionType, question : String, contentUrl : String, options : [String], correctAnswers : [String]) {
        self.id = id
        self.type = type
        self.question = question
        self.contentUrl = contentUrl
        self.options = options
        self.correctAnswers = correctAnswers
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case contentUrl
        case question
        case options
        case correctAnswers 
    }
}

public struct Answer {
    let question : Question
    let submitedAnswers : [String]
    init(question : Question, submitedAnswers : [String]) {
        self.question = question
        self.submitedAnswers = submitedAnswers
    }
}



