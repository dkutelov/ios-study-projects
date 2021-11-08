//
//  UserDeafultsData.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import Foundation

class UserDefaultsData {
    static var currentAccountId: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.currentAccountId)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currentAccountId)
        }
    }
}

extension UserDefaultsData {
    enum Keys {
        static let currentAccountId = "ud_current_account_id"
    }
}
