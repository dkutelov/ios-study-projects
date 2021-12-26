//
//  AudioService.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 23.12.21.
//

import Foundation
import AVFoundation

protocol AudioServiceDelegate {
    func songIsPlaying(currentTime: Double, duration: Double)
}

class AudioService {
    static let shared = AudioService()
    
    var timer: Timer?
    var delegate: AudioServiceDelegate?
    var audioPlayer: AVAudioPlayer!
    let songs = ["song-0","song-1","song-2"]
    
    private init() {}
    
    func play(song: Song) {
        let randomSong = songs.randomElement()!
        let songUrl = Bundle.main.url(forResource: randomSong, withExtension: "mp3")!
        
        audioPlayer = try! AVAudioPlayer(contentsOf: songUrl)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        startTimer()
    }
    
    func play(at time: Double) {
        audioPlayer.currentTime = time
        startTimer()
    }
    
    func pause() {
        audioPlayer.pause()
        stopTimer()
    }
    
    func resume() {
        audioPlayer.play()
        stopTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (time) in
            self.delegate?.songIsPlaying(currentTime: self.audioPlayer.currentTime, duration: self.audioPlayer.duration)
        }
    }
    
    private func stopTimer() {
        //stop timer
        timer?.invalidate()
        timer = nil
    }
}
