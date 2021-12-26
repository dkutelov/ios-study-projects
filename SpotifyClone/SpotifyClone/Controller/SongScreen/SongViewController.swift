//
//  SongViewController.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 23.12.21.
//

import UIKit

class SongViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    //MARK: - Props
    
    var album: Album!
    var selectedSongIndex: Int!
    var albumPrimartColor: CGColor!
    var userStartedSliding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioService.shared.delegate = self
        
        setBackground()
        updateUI()
        playSelectedSong()
        updateFavoriteButton()
        
        //seed data
//        album = CategoryService.shared.categories.randomElement()!.albums.randomElement()
//        albumPrimartColor = UIColor.blue.cgColor
//        selectedSongIndex = 0
    }
    
    //change status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Private Methods
    private func setBackground() {
        let backgroundColor = view.backgroundColor!.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [albumPrimartColor!, backgroundColor]
        gradientLayer.locations = [0.0, 0.4]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateUI() {
        thumbnailImageView.image = UIImage(named: album.image)
        trackSlider.value = 0
        currentTimeLabel.text = "00:00"
        playButton.layer.cornerRadius = playButton.frame.size.width / 2.0
    }
    
    private func playSelectedSong() {
        let selectedSong = album.songs[selectedSongIndex]
        
        titleLabel.text = selectedSong.title
        artistLabel.text = selectedSong.artist
        
        AudioService.shared.play(song: selectedSong)
    }
    
    private func stringFromTime(time: Double) -> String {
        let seconds = Int(time) % 60
        let minites = (Int(time) / 60) % 60
        return String(format: "%0.2d:%0.2d", minites, seconds)
    }
    
    private func updateFavoriteButton() {
        let song = album.songs[selectedSongIndex]
        
        if UserService.shared.isFavoritedSong(this: song) {
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    //MARK: - IBActions
    @IBAction func favoriteButtonDidTapped(_ sender: UIButton) {
        let song = album.songs[selectedSongIndex]
        
        if UserService.shared.isFavoritedSong(this: song) {
            UserService.shared.unfavoriteSong(this: song)
            favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            UserService.shared.favoriteSong(this: song)
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        }
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        
        // eliminate when slider and get value when sliding has stopped
        if sender.isContinuous {
            sender.isContinuous = false
            userStartedSliding = true
        } else {
            AudioService.shared.play(at: Double(sender.value))
            userStartedSliding = false
            sender.isContinuous = true
        }
    }
    
    @IBAction func previosButtonDidTapped(_ sender: UIButton) {
        selectedSongIndex = max(0, selectedSongIndex - 1)
        updateFavoriteButton()
        playSelectedSong()
    }
    
    @IBAction func playButtonDidTapped(_ sender: UIButton) {
        if sender.tag == K.TagPause {
            AudioService.shared.pause()
            sender.setImage(UIImage(named: "play"), for: .normal)
            sender.tag = K.TagPlay
        } else if sender.tag == K.TagPlay {
            AudioService.shared.resume()
            sender.setImage(UIImage(named: "pause"), for: .normal)
            sender.tag = K.TagPause
        }
                    
    }
    
    @IBAction func nextButtonDidTapped(_ sender: UIButton) {
        selectedSongIndex = min(album.songs.count, selectedSongIndex + 1)
        updateFavoriteButton()
        playSelectedSong()
    }
    
    @IBAction func closeButtonDidTapped(_ sender: UIButton) {
        // Hide presented modally (also full screen) controller
        dismiss(animated: true, completion: nil)
        
        AudioService.shared.pause()
    }
    
}

//MARK: - AudioServiceDelegate

extension SongViewController: AudioServiceDelegate {
    func songIsPlaying(currentTime: Double, duration: Double) {
        trackSlider.maximumValue = Float(duration)
        
        
        if !userStartedSliding { //stop updating when the user is sliding
            trackSlider.value = Float(currentTime)
        }
       
        durationLabel.text = stringFromTime(time: duration)
        currentTimeLabel.text = stringFromTime(time: currentTime)
    }
}

