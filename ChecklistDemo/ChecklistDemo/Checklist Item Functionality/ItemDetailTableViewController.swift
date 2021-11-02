//
//  AddItemTableViewController.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import UIKit

protocol ItemDetailTableViewControllerDelegate: AnyObject {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailTableViewController)
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var datePickerCell: UITableViewCell!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Properties
    weak var delegate: ItemDetailTableViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    var isDatePickerVisible: Bool = false
    var dueDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit item"
            textField.text = item.itemName
            doneButton.isEnabled = true
            dueDate = item.dueDate
        }
        
        updateDateLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    // MARK: - IBAction
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.itemName = textField.text!
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = dueDate
            item.scheduleNotification()
            delegate?.itemDetailViewController(self, didFinishEditing: item)
            return
        }
        
        let checklistItem = ChecklistItem(textField.text!,
                                          isChecked: false,
                                          shouldRemind: shouldRemindSwitch.isOn,
                                          dueDate: dueDate)
        checklistItem.scheduleNotification()
        delegate?.itemDetailViewController(self, didFinishAddingItem: checklistItem)
    }
    
    @IBAction func dateDidChange(_ sender: UIDatePicker) {
        dueDate = datePicker.date
        updateDateLabel()
        datePicker.setDate(dueDate, animated: false)
        
    }
    
    
    @IBAction func shouldRemindToggled(_ sender: UISwitch) {
        textField.resignFirstResponder()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            print("We have permission")
        }
    }
    
    // MARK: - Helpers
    private func updateDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        dueDateLabel.text = formatter.string(from: dueDate)
    }
    
    private func showDatePicker() {
        isDatePickerVisible = true
        
        let indexPathDatePicker = IndexPath(row: 2, section: 1)
        tableView.insertRows(at: [indexPathDatePicker], with: .fade)
        dueDateLabel.textColor = dueDateLabel.tintColor
    }
    
    private func hideDatePicker() {
        if isDatePickerVisible {
            isDatePickerVisible = false
            let indexPathDatePicker = IndexPath(row: 2, section: 1)
            tableView.deleteRows(at: [indexPathDatePicker], with: .fade)
            dueDateLabel.textColor = .black
        }
    }
}

extension ItemDetailTableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideDatePicker()
    }
}

extension ItemDetailTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 1 && isDatePickerVisible else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row == 2 && indexPath.section == 1 else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        
        return datePickerCell
    }
}

extension ItemDetailTableViewController {
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row == 1 && indexPath.section == 1 else {
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        textField.resignFirstResponder()
        
        if indexPath.section == 1 && indexPath.row == 1 {
            isDatePickerVisible ? hideDatePicker() : showDatePicker()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard indexPath.row == 2 && indexPath.section == 1 else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        
        return 217.0
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        var newIndexPath = indexPath
        
        if indexPath.section == 1 && indexPath.row == 2 {
            newIndexPath = IndexPath(row: 0, section: indexPath.section)
        }
        
        return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
    }
}
