//
//  LocationAnnotation.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 24.11.21.
//

import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    // coordinate is required from the protocol MKAnnotation
    var coordinate: CLLocationCoordinate2D
    let locationType: String
    
    init(coordinate: CLLocationCoordinate2D, locationType: String) {
        self.coordinate = coordinate
        self.locationType = locationType
    }
}

