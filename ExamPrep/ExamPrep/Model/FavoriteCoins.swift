//
//  FavoriteCoins.swift
//  ExamPrep
//
//  Created by Dari Kutelov on 5.11.21.
//

import Foundation
import RealmSwift

class Favorites: Object {
    @Persisted var userId: String = ""
    @Persisted var coins: List<String> = List<String>()
    
    override class func primaryKey() -> String? {
        return "userId"
    }
}
