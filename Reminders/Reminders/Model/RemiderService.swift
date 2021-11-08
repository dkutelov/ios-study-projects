//
//  RemiderService.swift
//  Reminders
//
//  Created by Dari Kutelov on 8.11.21.
//

import Foundation

class ReminderService {
    static let shared = ReminderService()
    
    private var reminders = [Reminder]()
    
    // Create
    func create(reminder: Reminder) {
        reminders.append(reminder)
    }
    
    // Update
    func update(reminder: Reminder, index: Int) {
        reminders[index] = reminder
    }
    
    // Get # of reminder
    func getCount() -> Int { reminders.count }
    
    // Get specific reminder
    func getReminder(index: Int) -> Reminder { reminders[index]}
    
    // Toggle completed status
    func toggleCompleted(index: Int) {
        let reminder = getReminder(index: index)
        reminder.isCompleted = !reminder.isCompleted
    }
    
    // Get list of reminders
    func getReminders() -> [Reminder] { reminders }
    
    // Delete a reminder
    func delete(index: Int) {
        reminders.remove(at: index)
    }
    
    // Get favorite reminder
    func getFavoriteReminder() -> Reminder? { reminders.first }
}
