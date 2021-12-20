//
//  CategoryService.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 20.12.21.
//

import Foundation

class CategoryService {
    static let shared = CategoryService()
    let categories: [Category]
    
    private init() {
        let categoriesUrl = Bundle.main.url(forResource: "categories", withExtension: "json")!
        let data = try! Data(contentsOf: categoriesUrl)
        let decoder = JSONDecoder()
        categories = try! decoder.decode([Category].self, from: data)
    }
    
    func getCategories() -> [Category] {
        return categories
    }
}
