//
//  MediaManager.swift
//  QuizApp
//
//  Created by Wilson Shakya on 04/05/21.
//

import Foundation
import AVKit

class MediaManager  {
    private static var player : AVPlayer!
    
    static func playVideo(url : String) -> AVPlayerLayer! {
        guard let url = URL(string: url) else {return nil  }
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        return playerLayer
    }
    
    static func playAudio(url : String) {
        guard let url = URL(string: url) else { return }
        let playerItem = AVPlayerItem(url:url)
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
    }
    
    static func play() {
        guard let _player = player else {return}
        _player.play()
    }
    
    static func pause() {
        guard let _player = player else {return}
        _player.pause()
    }
}
