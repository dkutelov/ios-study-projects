//
//  User.swift
//  ApiDemo-L8
//
//  Created by Dari Kutelov on 3.11.21.
//

import Foundation

struct User {
    var id: String?
    var username: String
    var email: String
    var password: String
    var avatarUrl: String?
    
    init(id: String, username: String, email: String, password: String, avatarUrl: String?) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.avatarUrl = avatarUrl
    }
    
    init(from userDict: [String: String?]) {
        id = userDict["id"] ?? ""
        username = userDict["username"]! ?? ""
        email = userDict["email"]! ?? ""
        password = userDict["password"]! ?? ""
        avatarUrl = userDict["avatarUrl"] ?? ""
    }
}

extension User {
    func toDict() -> [String: String]{
        let userDict: [String: String]  = [
            "username": username,
            "email": email,
            "password":password,
            "avatarUrl": avatarUrl ?? ""
        ]
        
        return userDict
    }
}
