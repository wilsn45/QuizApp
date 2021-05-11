//
//  RouterMock.swift
//  QuizAppTests
//
//  Created by Wilson Shakya on 04/05/21.
//

import Foundation
import UIKit
@testable import QuizApp

class RouterMock : RouterType {
    static var isNavigatedToResult = false
    func navigateToResultViewController(source : UIViewController) {
        RouterMock.isNavigatedToResult = true
    }
}
