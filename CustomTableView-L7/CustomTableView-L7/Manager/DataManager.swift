//
//  DataManager.swift
//  CustomTableView-L7
//
//  Created by Dari Kutelov on 3.11.21.
//

import Foundation
import UIKit

class DataManager {
    static var chatMessages: [ChatMessage] = []
}

extension DataManager {
    class func loadChatMessages() {
        chatMessages.removeAll()
        
        chatMessages.append(ChatMessage(name: "Joe Doe",
                                        lastMessage: "Hi, how are you?",
                                        dateOfLastMessage: Date(),
                                        //avatar: UIImage(named: "avatar-boy"),
                                        avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmvW0i-CVCKJSO97JmNbHdeMsvutvHK4g-Jg&usqp=CAU",
                                        profileStatus: .active,
                                        unreadMessages: true,
                                        isFavorite: false))
        
        chatMessages.append(ChatMessage(name: "Sarah Holms",
                                        lastMessage: "Hi, I am fine. How are you? Long time no see.",
                                        dateOfLastMessage: Date(timeInterval: 500, since: Date()),
                                        avatar:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDIvXqL3M8ChyrPgXupHhXkaW3-tA6f6y2nXdMcdVUSjXkW26nqn9pXdftebBk--3vTN0&usqp=CAU",
                                        profileStatus: .active,
                                        unreadMessages: false,
                                        isFavorite: false))
        
        chatMessages.append(ChatMessage(name: "Joe Doe",
                                        lastMessage: "Great. Let's go out for some sushi.",
                                        dateOfLastMessage: Date(timeInterval: 1000, since: Date()),
                                        avatar: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmvW0i-CVCKJSO97JmNbHdeMsvutvHK4g-Jg&usqp=CAU",
                                        profileStatus: .inactive,
                                        unreadMessages: true,
                                        isFavorite: false))
    }
}
