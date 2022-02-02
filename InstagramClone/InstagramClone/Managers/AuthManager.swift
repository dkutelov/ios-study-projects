//
//  AuthManager.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()
    
    enum AuthError: Error {
        case newUserCreation
    }
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    //Swift 5 Result type is implemented as an enum that has two cases: success and failure.
    //https://www.hackingwithswift.com/articles/161/how-to-use-result-in-swift
    public func signIn(email: String,
                       password: String,
                       completion: @escaping (Result<User, Error>) -> Void) {}

    public func signUp(email: String,
                       username: String,
                       password: String,
                       profilePicture: Data?,
                       completion: @escaping (Result<User, Error>) -> Void) {
        let newUser = User(username: username, email: email)
        // Create account
        auth.createUser(withEmail: email, password: password) { result, error in
            
            guard result != nil, error == nil else {
                completion(.failure(AuthError.newUserCreation))
                return
            }
            
            //Save user to firestore
            DatabaseManager.shared.createUser(newUser: newUser) { success in
                if success {
                    StorageManager.shared.uploadProfilePicture(
                        username: username,
                        data: profilePicture) { uploadSucces in
                            if uploadSucces {
                                completion(.success(newUser))
                            } else {
                                completion(.failure(AuthError.newUserCreation))
                            }
                        }
                } else {
                    completion(.failure(AuthError.newUserCreation))
                }
                
            }
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {}
}
