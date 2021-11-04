//
//  LocalDataManager.swift
//  RealmDemo-L9
//
//  Created by Dari Kutelov on 4.11.21.
//

import Foundation
import RealmSwift
import Realm


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
            configuration.schemaVersion = 2
            configuration.deleteRealmIfMigrationNeeded = true
            return try Realm(configuration: configuration, queue: queue)
        } catch {
            throw error
        }
    }
}
