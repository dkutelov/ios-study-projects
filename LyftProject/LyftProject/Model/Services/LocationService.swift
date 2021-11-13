//
//  LocationService.swift
//  LyftProject
//
//  Created by Dari Kutelov on 11.11.21.
//

import Foundation

class LocationService {
    static let shared = LocationService()
    
    private var recentLocations = [Location]()
    
    private init() {
        loadData()
    }
    
    private func loadData() {
        let locationsUrl = Bundle.main.url(forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: locationsUrl)
        let decoder = JSONDecoder()
        recentLocations = try! decoder.decode([Location].self, from: data)
    }
    
    func getRecentLocations() -> [Location] {
        return recentLocations
    }
}
