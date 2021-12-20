//
//  Song.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 20.12.21.
//

import Foundation

class Song: Codable {
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}
