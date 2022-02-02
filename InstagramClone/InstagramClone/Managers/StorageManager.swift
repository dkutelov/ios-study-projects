//
//  Storage.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    let storage = Storage.storage().reference()
    
    public func uploadProfilePicture(
        username: String,
        data: Data?,
        comletion: @escaping (Bool) -> Void
    ) {
        guard let pictureData = data else { return }
        storage.child("\(username)/profile_picture.png").putData(pictureData, metadata: nil) { _, error in
            comletion(error == nil)
        }
    }
}
