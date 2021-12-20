//
//  Category.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 20.12.21.
//

import Foundation

class Category: Codable {
    let title: String
    let subtitle: String
    let albums: [Album]
    
    init(title: String, subtitle: String, albums: [Album]){
        self.title = title
        self.subtitle = subtitle
        self.albums = albums
    }
}
