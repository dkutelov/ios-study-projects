//
//  UserManager.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 2.01.22.
//

import Foundation
import Firebase

class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    func registerUser(email: String,
                      password: String,
                      completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                completion(error)
                return
            }
            
            print(authResult!)
            completion(nil)
        }
    }
    
    func loginUser(email: String,
               password: String,
               completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
