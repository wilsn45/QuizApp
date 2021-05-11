//
//  QuestionViewModel.swift
//  QuizApp
//
//  Created by Wilson Shakya on 01/05/21.
//

import Foundation
import UIKit //Could be replacec by middle layer 

class QuestionViewModel {
    
    var selectedOption = [String]()
    var questions: [Question]? = nil
    var questionCounter = 0
    var coreDataManager : CoreDataManagerType!
    var router : RouterType!
    @Published var currentQuestion : Question!
    
    init (coreDataManager : CoreDataManagerType, router : RouterType) {
        self.coreDataManager = coreDataManager
        self.router = router
    }
    
    func getAPIData() {
        let request = QuestionAPI()
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest() { [weak self] (model, error) in
            guard let weakself = self else {return }
            if let _ = error {
                //Handle Network Error
            } else {
                if model!.success {
                    guard let _model = model else {return }
                    weakself.questions = _model.data
                    weakself.currentQuestion = weakself.questions![0]
                } else {
                    //Handle Data Error
                }
            }
        }
    }
    
    func submitAnswer() {
        let answer = Answer(question : currentQuestion, submitedAnswers : selectedOption)
        coreDataManager.recordAnswer(answer: answer)
        questionCounter = questionCounter+1
        selectedOption = []
        currentQuestion = questions![questionCounter]
    }
    
    func optionSelected(value : String) {
        if selectedOption.contains(value) {
            selectedOption.removeAll(where: {$0 == value})
        } else {
            selectedOption.append(value)
        }
        selectedOption.sort()
    }
    
    func navigateToResult (sender : Any) {
        let answer = Answer(question : currentQuestion, submitedAnswers : selectedOption)
        coreDataManager.recordAnswer(answer: answer)
        router.navigateToResultViewController(source : sender as! UIViewController)
    }
    
}
