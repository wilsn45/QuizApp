//
//  AudioQuestionSection.swift
//  QuizApp
//
//  Created by Wilson Shakya on 03/05/21.
//


import UIKit

class AudioQuestionSection: UITableViewCell {
    public static var identifier = "AudioQuestionSection"
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var audioView: UIView!
    @IBOutlet weak var playPauseBtn: UIButton!
    var isPlaying = false
    var playAudio : Bool {
        get {
            return isPlaying
        }set {
            if newValue {
                MediaManager.play()
                isPlaying = true
                playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
            } else {
                MediaManager.pause()
                isPlaying = false
                playPauseBtn.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
            }
        }
    }
    
    var item: Question! {
        didSet {
            titleLabel.text = item.question
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func playPausePressed(_ sender: Any) {
        playAudio = !playAudio
    }
}

extension AudioQuestionSection {
    func playMedia() {
        MediaManager.playAudio(url: item.contentUrl)
        playAudio = true
    }
}
