//
//  ChecklistItem.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import Foundation
import UserNotifications

class ChecklistItem: Codable {
    var itemName: String
    var isChecked: Bool
    var shouldRemind: Bool
    var dueDate: Date
    var itemId = -1
    
    init(_ itemName: String, isChecked: Bool, shouldRemind: Bool, dueDate: Date) {
        self.itemName = itemName
        self.isChecked = isChecked
        self.shouldRemind = shouldRemind
        self.dueDate = dueDate
        itemId = DataModel.nextChecklistItem()
    }
    
    deinit {
        removeNotification()
    }
    
//    required init(from decoder: Decoder) throws {
//        <#code#>
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        <#code#>
//    }
    
    func scheduleNotification() {
        // when start edit => remove existing notification
        removeNotification()
        
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Remider:"
            content.body = "\(itemName)"
            content.sound = .default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: "\(itemId)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    private func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemId)"])
    }
}

extension ChecklistItem: Equatable {
    static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        lhs.itemName == rhs.itemName &&
            lhs.isChecked == rhs.isChecked
    }
}
