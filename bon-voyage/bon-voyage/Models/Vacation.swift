//
//  Vacation.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 30.12.21.
//

import Foundation

struct Vacation {
    let price: Int
    let title: String
    let description: String
    let images: [String]
    let activities: String
    let airFare: String
    let numberOfDays: Int
    
    init(price: Int,  description: String, title: String, images: [String], activities: String, airFare: String, numberOfDays: Int) {
        self.price = price
        self.title = title
        self.description = description
        self.images = images
        self.activities = activities
        self.airFare = airFare
        self.numberOfDays = numberOfDays
    }
    
    //For data from Firestore
    init(data: [String: Any]) {
        self.price = data["price"] as? Int ?? 0
        self.title = data["title"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.activities = data["activities"] as? String ?? ""
        self.images = data["images"] as? [String] ?? [String]()
        self.airFare = data["airFare"] as? String ?? ""
        self.numberOfDays = data["numberOfDays"] as? Int ?? 0
    }
}
