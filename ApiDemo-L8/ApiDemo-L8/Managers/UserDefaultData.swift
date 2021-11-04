//
//  UserDefaultData.swift
//  ApiDemo-L8
//
//  Created by Dari Kutelov on 4.11.21.
//

import Foundation

class UserDefaultsData {
    static var email: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.email)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.email)
        }
    }
    static var numberOfAppOpens: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.numberOfAppOpens)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.numberOfAppOpens)
        }
    }
    
    static var userId: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.userId)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userId)
        }
    }
}

extension UserDefaultsData {
    enum Keys {
        static let email = "ud_user-email"
        static let numberOfAppOpens = "ud_number-of-app-open"
        static let userId = "ud_user-id"
    }
}

fileprivate extension String { //fileprivate - only for current file
    static let email = "ud_user-email"
    static let numberOfAppOpens = "ud_number-of-app-open"
}
