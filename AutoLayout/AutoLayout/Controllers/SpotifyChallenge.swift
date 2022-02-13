//
//  SpotifyChallenge.swift
//  AutoLayout
//
//  Created by Dariy Kutelov on 13.02.22.
//

import UIKit

class SpotifyChallenge: UIViewController {
    
    let margin: CGFloat = 20
    let spacing: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Playback"
    }
    
    func setupViews() {
        
        let offlineLabel = makeLabel(withText: "Offline")
        let offlineSwitch = makeSwitch(isOn: false)
        let offlineSublabel = makeSubLabel(withText: "When you go offline, you'll only be able to play the music and podcasts you've downloaded.")
        
        let crossfadeLabel = makeBoldLabel(withText: "Crossfade")
        let crossfadeMinLabel = makeSubLabel(withText: "0s")
        let crossfadeMaxLabel = makeSubLabel(withText: "12s")
        let crossfadeProgressView = makeProgressView()

        let gaplessPlaybackLabel = makeLabel(withText: "Gapless Playback")
        let gaplessPlaybackSwitch = makeSwitch(isOn: true)

        let hideSongsLabel = makeLabel(withText: "Hide Unplayable Songs")
        let hideSongsSwitch = makeSwitch(isOn: true)

        let enableNormalizationLabel = makeLabel(withText: "Enable Audio Normalization")
        let enableNormalizationSwitch = makeSwitch(isOn: true)
        
        view.addSubview(offlineLabel)
        view.addSubview(offlineSwitch)
        view.addSubview(offlineSublabel)
        
        view.addSubview(crossfadeLabel)
        view.addSubview(crossfadeMinLabel)
        view.addSubview(crossfadeProgressView)
        view.addSubview(crossfadeMaxLabel)

        view.addSubview(gaplessPlaybackLabel)
        view.addSubview(gaplessPlaybackSwitch)

        view.addSubview(hideSongsLabel)
        view.addSubview(hideSongsSwitch)

        view.addSubview(enableNormalizationLabel)
        view.addSubview(enableNormalizationSwitch)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            //Offline label, switch and sublabel
            offlineLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            offlineLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            offlineSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            offlineSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            offlineSublabel.topAnchor.constraint(equalTo: offlineLabel.bottomAnchor, constant: margin),
            offlineSublabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            offlineSublabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            //Crossfade label
            crossfadeLabel.topAnchor.constraint(equalTo: offlineSublabel.bottomAnchor, constant: spacing),
            crossfadeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            crossfadeMinLabel.topAnchor.constraint(equalTo: crossfadeLabel.bottomAnchor, constant: spacing),
            crossfadeMinLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            crossfadeMaxLabel.topAnchor.constraint(equalTo: crossfadeLabel.bottomAnchor, constant: spacing),
            crossfadeMaxLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            crossfadeProgressView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: spacing),
            crossfadeProgressView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -spacing),
            crossfadeProgressView.centerYAnchor.constraint(equalTo: crossfadeMinLabel.centerYAnchor),
            
            //Gapless Playback label and switch
            gaplessPlaybackLabel.topAnchor.constraint(equalTo: crossfadeMinLabel.bottomAnchor, constant: spacing),
            gaplessPlaybackLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            gaplessPlaybackSwitch.centerYAnchor.constraint(equalTo: gaplessPlaybackLabel.centerYAnchor),
            gaplessPlaybackSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            //Hide song label and switch
            hideSongsLabel.topAnchor.constraint(equalTo: gaplessPlaybackLabel.bottomAnchor, constant: spacing),
            hideSongsLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            hideSongsSwitch.centerYAnchor.constraint(equalTo: hideSongsLabel.centerYAnchor),
            hideSongsSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            //Enable normalization label and switch
            enableNormalizationLabel.topAnchor.constraint(equalTo: hideSongsLabel.bottomAnchor, constant: spacing),
            enableNormalizationLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            enableNormalizationSwitch.centerYAnchor.constraint(equalTo: enableNormalizationLabel.centerYAnchor),
            enableNormalizationSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
    }
}
