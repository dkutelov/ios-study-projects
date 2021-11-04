//
//  LocalData.swift
//  RealmDemo-L9
//
//  Created by Dari Kutelov on 4.11.21.
//

//import Foundation
//
//class LocalData {
//    static var users: [User] = []
//
//    static func initializeUsers() -> User {
//        let user = User()
//        //user.id = UUID().uuidString
//        user.firstName = "Django"
//        user.lastName = "Djerry"
//        user.eBirthDate = Date(timeIntervalSince1970: 93434)
//        user.eGender = .male
//        user.height = 1.73
//        user.weight = 72
//        LocalData.writeInitializedUser(user: user)
//        return user
//    }
//
//    static func writeInitializedUser(user: User) {
//        try? LocalDataManager.realm.write({
//            LocalDataManager.realm.add(user)
//        })
//    }
//
//    static func printUsers() {
//        print(LocalDataManager.realm.objects(User.self))
//    }
//}
