//
//  RideQuoteService.swift
//  LyftProject
//
//  Created by Dari Kutelov on 11.11.21.
//

import Foundation
import CoreLocation

class RideQuoteService {
    static let shared = RideQuoteService()
    
    private init() {
        
    }
    
    func getQuotes(pickupLocation: Location, dropoffLocation: Location) -> [RideQuote] {
        
        // Get Distance between 2 locations
        // convert to CLLocation
        let location1 = CLLocation(latitude: pickupLocation.lat, longitude: pickupLocation.lng)
        let location2 = CLLocation(latitude: dropoffLocation.lat, longitude: dropoffLocation.lng)
        
        let distance = location1.distance(from: location2)  // in meters
        let minAmount = 3.0
        
        return [
            RideQuote(thumbnail: "ride-shared", name: "Shared", capacity: "1-2", price: minAmount + distance * 0.005, time: Date()),
            RideQuote(thumbnail: "ride-compact", name: "Compact", capacity: "4", price: minAmount + distance * 0.009, time: Date()),
            RideQuote(thumbnail: "ride-large", name: "Large", capacity: "6", price: minAmount + distance * 0.015, time: Date())
        ]
    }
}
