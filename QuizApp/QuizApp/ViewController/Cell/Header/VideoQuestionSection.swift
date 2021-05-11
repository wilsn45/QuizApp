//
//  VideoQuestionSection.swift
//  QuizApp
//
//  Created by Wilson Shakya on 03/05/21.
//

import UIKit
import AVKit
class VideoQuestionSection: UITableViewCell {
    
    public static var identifier = "VideoQuestionSection"
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var videoView: UIView!
    @IBOutlet weak var playPauseBtn: UIButton!
    var player = AVPlayer()
    
    var isPlaying = false
    var playVideo : Bool {
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
    
    @IBAction func playPauseClicked(_ sender: Any) {
        playVideo = !playVideo
    }
    
}

extension VideoQuestionSection {
    func playMedia() {
        guard let playerLayer = MediaManager.playVideo(url: item.contentUrl) else {return}
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspect
        videoView.layer.addSublayer(playerLayer)
        playVideo = true
    }
}
