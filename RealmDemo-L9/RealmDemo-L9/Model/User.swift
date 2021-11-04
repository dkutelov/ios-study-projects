//
//  User.swift
//  RealmDemo-L9
//
//  Created by Dari Kutelov on 4.11.21.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var id: String = ""
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var birthday: String = ""
    @Persisted var gender: String = ""
    @Persisted var height: Double = 0.0
    @Persisted var weight: Double = 0.0
    @Persisted var createdAt: String = ""
    @Persisted var updatedAt: String = Date().dateInISO8601
    
    static override func primaryKey() -> String? {
        return "id"
    }
}

extension User {
    enum Gender: String {
        case male
        case female
        case unknown
    }
}

extension User {
    var eGender: Gender {
        get {
            return User.Gender(rawValue: self.gender) ?? .unknown
        }
        set {
            self.realm?.beginWrite() //locks the object until change is committed
            self.gender = newValue.rawValue
            try? self.realm?.commitWrite()
        }
    }
    
    var eBirthDate: Date? {
        get {
            let dateFormatter = ISO8601DateFormatter()
            return dateFormatter.date(from: self.birthday)
        }
        set {
            self.realm?.beginWrite()
            self.birthday = newValue?.dateInISO8601 ?? ""
            try? self.realm?.commitWrite()
        }
    }
}

extension User {
    var jsonValue: [String: Any] {
        var jsonObj = [String: Any]()
        
        jsonObj["firstName"] = self.firstName
        jsonObj["lastName"] = self.lastName
        jsonObj["birthday"] = self.birthday
        jsonObj["gender"] = self.gender
        jsonObj["height"] = self.height
        jsonObj["weight"] = self.weight
        
        return jsonObj
    }
}
