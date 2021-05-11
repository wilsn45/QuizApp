//
//  ResultViewModelTest.swift
//  QuizAppTests
//
//  Created by Wilson Shakya on 04/05/21.
//

import XCTest
@testable import QuizApp

class ResultViewModelTest: XCTestCase {
    
    var viewModel : ResultViewModel!

    override func setUpWithError() throws {
        viewModel = ResultViewModel(coreDataManager: CoreDataMaanagerMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchAnswers() throws {
        viewModel.fetchAnswers()
        XCTAssertNotNil(self.viewModel.currentQuestion)
    }

    func testNextQuestion() throws {
        let ans1 = Answer(question : Question(id :1, type : .Text, question : "Text Question", contentUrl : "", options : ["1","2","3"], correctAnswers : ["1"]), submitedAnswers : [])
        let ans2 = Answer(question :Question(id :2, type : .Image, question : "Image Question", contentUrl : "", options : ["one","two","three"], correctAnswers : ["one"]),submitedAnswers : [])
        viewModel.currentQuestion = ans1.question
        viewModel.answers = [ans1,ans2]
        viewModel.nextQuestion()
        XCTAssertEqual(viewModel.currentQuestion.id,2)
    }

}
