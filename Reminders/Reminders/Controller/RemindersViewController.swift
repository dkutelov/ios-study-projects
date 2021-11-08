//
//  RemindersViewController.swift
//  Reminders
//
//  Created by Dari Kutelov on 8.11.21.
//

import UIKit

class RemindersViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateSegue",
           let newReminderViewController = segue.destination as? NewReminderViewController,
           let infoButton = sender as? UIButton {
            newReminderViewController.reminderIndex = infoButton.tag
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func editItemDidPressed(_ sender: UIBarButtonItem) {
        
        if tableView.isEditing == true {
            tableView.isEditing = false
            sender.title = "Edit"
        } else {
            tableView.isEditing = true
            sender.title = "Done"
        }
        
    }
}

// MARK: Table view data source

extension RemindersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ReminderService.shared.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as? ReminderCell else {
            return UITableViewCell()
        }
        
        let reminder = ReminderService.shared.getReminder(index: indexPath.row)
        cell.update(reminder: reminder, index: indexPath.row)
    
        return cell
    }
    
    
}

// MARK: Table view delegate

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ReminderService.shared.toggleCompleted(index: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if user wants to delete a cell
        if editingStyle == .delete {
            // first delete the data
            ReminderService.shared.delete(index: indexPath.row)
            // remove the cell
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
