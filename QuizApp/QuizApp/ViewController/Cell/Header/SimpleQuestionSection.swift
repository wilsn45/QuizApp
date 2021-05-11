//
//  SimpleQuestionSection.swift
//  QuizApp
//
//  Created by Wilson Shakya on 03/05/21.
//

import UIKit

class SimpleQuestionSection: UITableViewCell {
    public static var identifier = "SimpleQuestionSection"
    @IBOutlet private var titleLabel: UILabel!
    
    var item: Question! {
        didSet {
            titleLabel.text = item.question
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
