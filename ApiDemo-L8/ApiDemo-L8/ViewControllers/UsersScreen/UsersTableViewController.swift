//
//  UsersTableViewController.swift
//  ApiDemo-L8
//
//  Created by Dari Kutelov on 4.11.21.
//

import UIKit
import RealmSwift

class UsersTableViewController: UITableViewController {

    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        NotificationCenter.default.addObserver(forName: .userDataLoaded, object: nil, queue: nil) {[weak self] _ in
            self?.loadData()
            self?.tableView.reloadData()
        }
        self.loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Load data
    func loadData() {
        users.removeAll()
        
        DispatchQueue.main.async {
            let filteredAndSortedUsers = LocalDataManager.realm.objects(User.self)
                .filter({ user in user.height > 0.9 })//.filter("height > %f", 1.7)
                .sorted(by: { $0.firstName < $1.firstName}) //.sorted(byKeyPath: "firstName", ascending: true)
            
            self.users.append(contentsOf: filteredAndSortedUsers)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userReusableCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        cell.setupWith(data: user)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentObj = users[indexPath.row]
        // if need to modify, can not the object, should write in realm
        
        DispatchQueue.main.async {
            try? LocalDataManager.realm.write {
                currentObj.firstName = "Obi"
            }
            self.loadData()
        }
    }
}
