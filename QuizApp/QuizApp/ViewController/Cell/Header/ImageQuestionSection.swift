//
//  ImageQuestionSection.swift
//  QuizApp
//
//  Created by Wilson Shakya on 03/05/21.
//


import UIKit

class ImageQuestionSection: UITableViewCell {
    public static var identifier = "ImageQuestionSection"
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var quesImageView: UIImageView!
    
    var item: Question! {
        didSet {
            titleLabel.text = item.question
            let url = URL(string: item.contentUrl)
            let data = try? Data(contentsOf: url!)
            quesImageView.image = UIImage(data: data!)
        }
    }
}
