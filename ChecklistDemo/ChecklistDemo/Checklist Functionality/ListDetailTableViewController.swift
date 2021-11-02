//
//  ListDetailTableViewController.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import UIKit

protocol ListDetailTableViewControllerDelegate: AnyObject {
    func ListDetailTableViewControllerDidCancel(_ controller: ListDetailTableViewController)
    func ListDetailTableViewController(_ controller: ListDetailTableViewController, didFinishAddingChecklist checklist: Checklist)
    func ListDetailTableViewController(_ controller: ListDetailTableViewController, didFinishEditingChecklist checklist: Checklist)
}


class ListDetailTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var checklistTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    //MARK: - Properties
    var editChecklist: Checklist?
    weak var delegate: ListDetailTableViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Checklist"
    
        if let checklist = editChecklist {
            title = "Edit Checklist"
            checklistTextField.text = checklist.name
            doneButton.isEnabled = true
        }
    }

    // MARK: - IBAction
    
    @IBAction func cancelButtonDidTapped(_ sender: UIBarButtonItem) {
        delegate?.ListDetailTableViewControllerDidCancel(self)
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIBarButtonItem) {
      
        guard let checklistText = checklistTextField.text else { return }
        
        if let checklist = editChecklist {
            checklist.name = checklistText
            delegate?.ListDetailTableViewController(self, didFinishEditingChecklist: checklist)
            return
        }
        
        let checklist = Checklist(checklistText)
        delegate?.ListDetailTableViewController(self, didFinishAddingChecklist: checklist)
    }
}

extension ListDetailTableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = checklistTextField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneButton.isEnabled = !newText.isEmpty
        return true
    }
}
