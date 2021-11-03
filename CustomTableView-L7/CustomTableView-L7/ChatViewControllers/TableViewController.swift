//
//  TableViewController.swift
//  CustomTableView-L7
//
//  Created by Dari Kutelov on 3.11.21.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let data: [ChatMessage] = DataManager.chatMessages
    var favoriteData: [ChatMessage] {
        DataManager.chatMessages.filter { $0.isFavorite }
    }
        
     // MARK: - Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch  section {
        case 0:
            return "Favorites"
        case 1:
            return "All"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return favoriteData.count
        case 1:
            return data.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatReusableCell", for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }

        let cellData = indexPath.section == 0 ? favoriteData[indexPath.row] : data[indexPath.row]
        cell.delegate = self
        cell.setupWith(data: cellData)
        
        return cell
    }
}

// MARK: - ChatTableViewCell Delegate

extension TableViewController: ChatTableViewCellDelegate {
    func didTabFavorite(cell: ChatTableViewCell) {
        self.tableView.reloadData()
    }
    
    func didTapEdit(cell: ChatTableViewCell) {
        print("from table view controller on cell with name \(cell.titleLabel.text ?? "")")
    }
}
