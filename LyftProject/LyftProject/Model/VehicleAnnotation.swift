//
//  VehicleAnnotation.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 16.11.21.
//

import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate:CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
