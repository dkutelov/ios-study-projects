//
//  UserManager.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 2.01.22.
//

import Foundation
import Firebase
import FirebaseFunctions

class UserManager {
    static let shared = UserManager()
    let auth = Auth.auth()
    
    private init() {}
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
       
    func registerUser(email: String,
                      password: String,
                      completion: @escaping (_ error: Error?) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                completion(error)
                return
            }
            
//            Functions.functions().httpsCallable("createStripeUser").call(["email": email]) { (result, error) in
//                // pass data as dictionary
//                if let error = error {
//                    debugPrint(error.localizedDescription)
//                    return
//                }
//                
//                completion(nil)
//            }
            completion(nil)
        }
    }
    
    func loginUser(email: String,
               password: String,
               completion: @escaping (_ error: Error?) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
    func logoutUser() {
        do {
            try auth.signOut()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
