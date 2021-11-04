//
//  RequestManager.swift
//  RealmDemo-L9
//
//  Created by Dari Kutelov on 4.11.21.
//

import Foundation
import Alamofire

enum NetworkErrors: Error {
    case cannotParseData
}

class RequestManager {
//    static let backgroundQueue = DispatchQueue.global(qos: .background) // background - lowest priority
    static let backgroundQueue = DispatchQueue(label: "Data queue", qos: .default)

    class func fetchAllUser(completion: @escaping((_ error: Error?) -> Void)) {
        AF.request("https://chat-ios-327009-default-rtdb.firebaseio.com/allusers/.json",
                   method: .get)
            .responseJSON { result in
                
                guard result.error == nil else {
                    completion(result.error)
                    return
                }
                
                guard let resultValue = result.value else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                guard let usersDict = resultValue as? [String: [String: Any]] else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                for userDict in usersDict {
                    var userData = userDict.value
                    userData["id"] = userDict.key
                    let user = User(value: userData)
                    
                    backgroundQueue.async {
                        let backgroundRealm = LocalDataManager.backgroundRealm(queue: backgroundQueue)
                        
                        try? backgroundRealm.write({
                            backgroundRealm.add(user, update: .all)
                        })
                    }
                    
//                    DispatchQueue.main.async {
//                        try? LocalDataManager.realm.write {
//                            LocalDataManager.realm.add(user, update: .all) // update all - updates all objects
//                        }
//                    }
                }
                DispatchQueue.main.async {
                    print(LocalDataManager.realm.objects(User.self))
                }
                
                NotificationCenter.default.post(name: .userDataLoaded, object: nil)
                completion(nil)
            }
    }
    
    class func uploadUser(user: User, completion: @escaping((_ userId: String?, _ error: Error?) -> Void)) {
        
        let userJson = user.jsonValue
        
        AF.request("https://chat-ios-327009-default-rtdb.firebaseio.com/allusers/.json",
                   method: .post,
                   parameters: userJson,
                   encoding: JSONEncoding.default)
            .responseJSON { result in
            
            guard result.error == nil else {
                completion(nil, result.error)
                return
            }
            
            guard let resultValue = result.value else {
                completion(nil, NetworkErrors.cannotParseData)
                return
            }
            
            guard let userDict = resultValue as? [String: String] else {
                completion(nil, NetworkErrors.cannotParseData)
                return
            }
                
            let userId = userDict["name"]
            print(userId!)
                
                completion(userId, nil)
        }
    }
}
