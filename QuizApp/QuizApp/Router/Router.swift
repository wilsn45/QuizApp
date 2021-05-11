//
//  Router.swift
//  QuizApp
//
//  Created by Wilson Shakya on 03/05/21.
//

import Foundation
import UIKit

protocol RouterType {
    func navigateToResultViewController(source : UIViewController)
}

class Router : RouterType {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func navigateToResultViewController(source : UIViewController) {
        if let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
             source.navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
}
