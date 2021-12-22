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
    var followers: Int
    
    init(name: String, artist: String, image: String, songs: [Song], followers: Int) {
        self.name = name
        self.artist = artist
        self.image = image
        self.songs = songs
        self.followers = followers
    }
}
