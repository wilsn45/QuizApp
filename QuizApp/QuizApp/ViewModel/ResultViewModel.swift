//
//  ResultViewModel.swift
//  QuizApp
//
//  Created by Wilson Shakya on 01/05/21.
//

import Foundation

class ResultViewModel {
    var selectedOption = [String]()
    var answerCounter = 0
    var answers: [Answer] = []
    var coreDataManager : CoreDataManagerType!
    @Published var currentQuestion : Question!
    
    init (coreDataManager : CoreDataManagerType) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchAnswers() {
        answers = coreDataManager.getAnswers()
        currentQuestion = answers[0].question
        selectedOption = answers[0].submitedAnswers
    }
    
    func nextQuestion() {
        answerCounter = answerCounter+1
        currentQuestion = answers[answerCounter].question
        selectedOption = answers[answerCounter].submitedAnswers
    }
}
