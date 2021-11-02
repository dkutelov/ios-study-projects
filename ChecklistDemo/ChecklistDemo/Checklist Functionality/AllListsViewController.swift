//
//  ChecklistViewController.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import UIKit

class AllListsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var dataModel: DataModel!
    let cellIdentifier = "ChecklistCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        
        if index >= 0 && index <  dataModel.checklists.count {
            let checklist = dataModel.checklists[index]
            performSegue(withIdentifier: "showItems", sender: checklist)
        }
    }
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CheckViewController,
           segue.identifier == "showItems" {
            destination.checklist = (sender as! Checklist)
        } else if let destination = segue.destination as? ListDetailTableViewController, segue.identifier == "addList"  {
            destination.delegate = self
        }
    }
    
    // MARK: - UITableView Helpers
    private func configureText(for cell: UITableViewCell, with checklist: Checklist) {
        let cellLabel = cell.textLabel
        cellLabel?.text = checklist.name
    }
}

//MARK: - Table View Data Source

extension AllListsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModel.checklists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        
        if let recycledCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = recycledCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel?.text = dataModel.checklists[indexPath.row].name
        cell.detailTextLabel?.text = "\(dataModel.checklists[indexPath.row].countUncheckedItems()) Remaining"
        cell.accessoryType = .detailDisclosureButton
        cell.tag = 1100
        return cell
    }
}

//MARK: - Table View Delegate

extension AllListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = dataModel.checklists[indexPath.row]
        
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        performSegue(withIdentifier: "showItems", sender: checklist)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "ListDetailTableViewController") as! ListDetailTableViewController
        
        controller.delegate = self
        controller.editChecklist = dataModel.checklists[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.checklists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

//MARK: - ListDetailTableViewController Delegate

extension AllListsViewController: ListDetailTableViewControllerDelegate {
    func ListDetailTableViewControllerDidCancel(_ controller: ListDetailTableViewController) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func ListDetailTableViewController(_ controller: ListDetailTableViewController, didFinishAddingChecklist item: Checklist) {
        
        let newRawIndex = dataModel.checklists.count
        dataModel.checklists.append(item)
        let indexPath = IndexPath(row: newRawIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
        
        navigationController?.popViewController(animated: true)
    }
    
    func ListDetailTableViewController(_ controller: ListDetailTableViewController, didFinishEditingChecklist item: Checklist) {
        
        if let index = dataModel.checklists.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
 
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension AllListsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if viewController == self { //back on same view
            dataModel.indexOfSelectedChecklist = -1
        }
    }
}
