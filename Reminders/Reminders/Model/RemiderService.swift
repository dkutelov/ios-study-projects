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
    
    private var url: URL
    
    private init() {
        url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("reminder.json")
        load()
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            reminders = try decoder.decode([Reminder].self, from: data)
        } catch {
            print("error loading file \(error.localizedDescription)")
        }
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(reminders)
            try data.write(to: url)
        } catch {
            print("error saving file \(error.localizedDescription)")
        }
    }
    
    // Create
    func create(reminder: Reminder) {
        var indexToInsert: Int?
        
        for (index, el) in reminders.enumerated() {
            if el.date.timeIntervalSince1970  > reminder.date.timeIntervalSince1970 {
                indexToInsert = index
                break
            }
        }
        
        if let indexToInsert = indexToInsert {
            reminders.insert(reminder, at: indexToInsert)
        } else {
            reminders.append(reminder)
        }
        
        save()
    }
    
    // Update
    func update(reminder: Reminder, index: Int) {
        reminders[index] = reminder
        
        save()
    }
    
    // Get # of reminder
    func getCount() -> Int { reminders.count }
    
    // Get specific reminder
    func getReminder(index: Int) -> Reminder { reminders[index]}
    
    // Toggle completed status
    func toggleCompleted(index: Int) {
        let reminder = getReminder(index: index)
        reminder.isCompleted = !reminder.isCompleted
        
        save()
    }
    
    // Get list of reminders
    func getReminders() -> [Reminder] { reminders }
    
    // Delete a reminder
    func delete(index: Int) {
        reminders.remove(at: index)
        
        save()
    }
    
    // Get favorite reminder
    func getFavoriteReminder() -> Reminder? {

        var allReminder = Array(reminders)
        allReminder.shuffle()
        return allReminder.randomElement()
    }
}
