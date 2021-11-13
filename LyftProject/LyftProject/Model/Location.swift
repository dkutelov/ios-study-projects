//
//  Location.swift
//  LyftProject
//
//  Created by Dari Kutelov on 11.11.21.
//

import Foundation

class Location: Codable {
    var title: String = ""
    var subtitle: String = ""
    var  lat: Double
    var lng: Double
    
    init(title: String, subtitle: String, lat: Double, lng: Double) {
        self.title = title
        self.subtitle = subtitle
        self.lat = lat
        self.lng = lng
    }
}
