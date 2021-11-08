//
//  NewReminderViewController.swift
//  Reminders
//
//  Created by Dari Kutelov on 8.11.21.
//

import UIKit

class NewReminderViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var completedSwitch: UISwitch!
    
    // MARK: - Properties
    var reminderIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIonEdit()
    }
    
    @IBAction func saveButtonDidTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        
        let reminder = Reminder(title: title, date: datePicker.date, isCompleted: completedSwitch.isOn)
        print(reminder)
        
        if let reminderIndex = reminderIndex {
            ReminderService.shared.update(reminder: reminder, index: reminderIndex)
        } else {
            ReminderService.shared.create(reminder: reminder)
        }
        navigationController!.popViewController(animated: true)
    }
    
    
    private func updateUIonEdit() {
        if let reminderIndex = reminderIndex {
            let reminder = ReminderService.shared.getReminder(index: reminderIndex)
            
            titleTextField.text = reminder.title
            datePicker.date = reminder.date
            completedSwitch.isOn = reminder.isCompleted
        }
    }
}
