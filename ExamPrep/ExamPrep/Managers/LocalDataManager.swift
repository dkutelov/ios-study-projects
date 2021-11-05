//
//  LocalDataManager.swift
//  ExamPrep
//
//  Created by Dari Kutelov on 5.11.21.
//

import Foundation
import RealmSwift

enum LocalDataManagerError: Error {
    case wrongQueue
}

class LocalDataManager {
    static let realm: Realm = {
        return try! initializeRealm(checkForMainThread: true)
    }()
    
    static func backgroundRealm(queue:DispatchQueue = DispatchQueue.main) -> Realm {
        return try! initializeRealm(checkForMainThread: false, queue: queue)
    }
    
    class func initializeRealm(checkForMainThread: Bool = false, queue: DispatchQueue = DispatchQueue.main) throws -> Realm {
        
        if checkForMainThread {
            guard OperationQueue.current?.underlyingQueue == DispatchQueue.main else {
                throw LocalDataManagerError.wrongQueue
            }
        }
        
        do {
            var configuration =  Realm.Configuration.defaultConfiguration
            configuration.schemaVersion = 1
            configuration.deleteRealmIfMigrationNeeded = true
            return try Realm(configuration: configuration, queue: queue)
        } catch {
            throw error
        }
    }
    
    static let favoriteCoins: Favorites = {
        if let favoriteObj =  LocalDataManager.realm.object(ofType: Favorites.self, forPrimaryKey: "123") {
            return favoriteObj
        }
        
        let favoriteObj = Favorites()
        favoriteObj.userId = "123"
        LocalDataManager.realm.beginWrite()
        realm.add(favoriteObj, update: .all)
        try? LocalDataManager.realm.commitWrite()
        
        return favoriteObj
    }()
}

