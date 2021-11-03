//
//  ChatMessage.swift
//  CustomTableView-L7
//
//  Created by Dari Kutelov on 3.11.21.
//

import Foundation
import UIKit

class ChatMessage {
    var name: String
    var lastMessage: String
    var dateOfLastMessage: Date
//    var avatar: UIImage?
    var avatar: String?
    var profileStatus: Status
    var unreadMessages: Bool
    var isFavorite: Bool
    
    init(name: String,
         lastMessage: String,
         dateOfLastMessage: Date,
         avatar: String?,
         profileStatus: Status,
         unreadMessages: Bool,
         isFavorite: Bool) {
        self.name = name
        self.lastMessage = lastMessage
        self.dateOfLastMessage = dateOfLastMessage
        self.avatar = avatar
        self.profileStatus = profileStatus
        self.unreadMessages = unreadMessages
        self.isFavorite = isFavorite
    }
}

extension ChatMessage {
    enum Status {
        case active, inactive
    }
}
