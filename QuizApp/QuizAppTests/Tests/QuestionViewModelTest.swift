//
//  QuizAppTests.swift
//  QuizAppTests
//
//  Created by Wilson Shakya on 01/05/21.
//

import XCTest
import UIKit
@testable import QuizApp

class QuestionViewModelTest: XCTestCase {
    
    var viewModel : QuestionViewModel!

    override func setUpWithError() throws {
        viewModel = QuestionViewModel(coreDataManager : CoreDataMaanagerMock(),router : RouterMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetAPIData()  {
        self.viewModel.getAPIData()
        sleep(2)
        //In general enviroment, we mock the api and validate expected output against mock response.
        XCTAssertNotNil(self.viewModel.currentQuestion)
    }
    
    func testSubmitAnswer() {
        let ques1 = Question(id :1, type : .Text, question : "Text Question", contentUrl : "", options : ["1","2","3"], correctAnswers : ["1"])
        let ques2 = Question(id :2, type : .Image, question : "Image Question", contentUrl : "", options : ["one","two","three"], correctAnswers : ["one"])
        viewModel.currentQuestion = ques1
        viewModel.questions = [ques1,ques2]
        viewModel.submitAnswer()
        XCTAssertEqual(viewModel.currentQuestion.id,2)
    }
    
    func testOptionSelected() {
        viewModel.selectedOption = ["1","2","3"]
        viewModel.optionSelected(value: "4")
        XCTAssertEqual(viewModel.selectedOption.count,4)
    }
    
    func testNavigateToResult() {
        let ques1 = Question(id :1, type : .Text, question : "Text Question", contentUrl : "", options : ["1","2","3"], correctAnswers : ["1"])
        viewModel.currentQuestion = ques1
        viewModel.navigateToResult(sender: UIViewController())
        XCTAssertTrue(RouterMock.isNavigatedToResult)
    }

}
