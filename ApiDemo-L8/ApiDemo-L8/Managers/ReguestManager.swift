//
//  ReguestManager.swift
//  ApiDemo-L8
//
//  Created by Dari Kutelov on 3.11.21.
//

import Foundation

class RequestManager {
    static func fetchUsers(completion: @escaping((_ error: Error?) -> Void)) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        guard let URL = URL(string: "\(K.apiUrl)/users/.json") else { return }
        
        var request = URLRequest(url: URL)
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print(statusCode)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:[String: String?]]
                for user in json {
                    var userData = user.value
                    userData["id"] = user.key
                    let newUser = User(from: userData)
                    LocalData.users.append(newUser)
                }
              
                // call notificaiton on the main tred
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .userDataLoaded, object: nil)
                }
        
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    static func createUser(user: User, completion: @escaping((_ userId: String?, _ error: Error?) -> Void)) {
        let session = URLSession(configuration: .default)
        
        guard let URL = URL(string: "\(K.apiUrl)/users/.json") else { return }
        
        var request = URLRequest(url: URL)
        
        request.httpMethod = "POST"
        
        let bodyObject: [String: String] = user.toDict()
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            print(statusCode)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:String]
                print(json)
                // returns ["name": "-Mnakz-v56VRcS_agbZ4"]
                
                DispatchQueue.main.async {
                    completion(json["name"], nil)
                    NotificationCenter.default.post(name: .userDataLoaded, object: nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }
        
        task.resume()
    }
}
