//
//  Location.swift
//  LyftProject
//
//  Created by Dari Kutelov on 11.11.21.

import Foundation
import MapKit

class Location: Codable {
    var title: String = ""
    var subtitle: String = ""
    var lat: Double
    var lng: Double
    
    init(title: String, subtitle: String, lat: Double, lng: Double) {
        self.title = title
        self.subtitle = subtitle
        self.lat = lat
        self.lng = lng
    }
    
    // Init from placemark
    init(placemark: MKPlacemark) {
        self.title = placemark.name ?? ""
        self.subtitle = placemark.title ?? ""
        self.lat = placemark.coordinate.latitude
        self.lng = placemark.coordinate.longitude
    }
}
