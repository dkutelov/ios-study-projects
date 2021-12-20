//
//  Album.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 20.12.21.
//

import Foundation

class Album: Codable {
    let name: String
    let artist: String
    let image: String
    let songs: [Song]
    
    init(name: String, artist: String, image: String, songs: [Song]) {
        self.name = name
        self.artist = artist
        self.image = image
        self.songs = songs
    }
}
