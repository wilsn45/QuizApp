//
//  QuestionTableViewCell.swift
//  QuizApp
//
//  Created by Wilson Shakya on 02/05/21.
//

import UIKit

class OptionCell: UITableViewCell {
    static let identifier = "OptionCell"
    var onButtonTapped : ((Bool) -> Void)? = nil
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    var isChecked = false
    
    var option: String! {
        didSet {
            questionLabel.text = option
            isChecked = false
            btnCheck.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnCheckClicked(_ sender: Any) {
        isChecked = !isChecked
        if isChecked == true {
            btnCheck.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            btnCheck.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        }
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped(isChecked)
        }
    }
    
    public func showResult(isCorrectAnswer:Bool, isSubmittedAnswer : Bool) {
        btnCheck.isEnabled = false
        if !isSubmittedAnswer && !isCorrectAnswer {
            btnCheck.tintColor = UIColor.black
            return
        }
        if isSubmittedAnswer {
            btnCheck.tintColor = UIColor.red
        }
        if isCorrectAnswer {
            btnCheck.tintColor = UIColor.green
        }
        btnCheck.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
    }
}
