//
//  DatabaseManager.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//


import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
}
