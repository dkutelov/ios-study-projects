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
    
    let storage = Storage.storage()
}
