//
//  AccountsTableViewController.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import UIKit

class AccountsTableViewController: UITableViewController {
    
    //  MARK: - Properties
    var accounts = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newAccountViewController = segue.destination as? NewAccountViewController{
            newAccountViewController.delegate = self
        }
        
        if let accountDetailViewController = segue.destination as? AccountDetailViewController,
           let accountCell = sender as? AccountTableViewCell,
           let account = accountCell.account {
            accountDetailViewController.account = account
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accounts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountsReusableCell", for: indexPath) as? AccountTableViewCell else {
            return UITableViewCell()
        }
        
        let account = self.accounts[indexPath.row]
        
        cell.account = account
        
        return cell
    }
    
    // MARK: - Helpers
    
    func loadData() {
        self.accounts.removeAll()
        
        let currentAccountCount = UserDefaultsData.currentAccountId
        let decoder = JSONDecoder()
        
        for i in 0..<currentAccountCount {
            if let data = UserDefaults.standard.data(forKey: "\(i)") {
                do {
                    let account = try decoder.decode(Account.self, from: data)
                    accounts.append(account)
                } catch {
                    print("Unable to Decode Account (\(error))")
                }
            }
        }
        
        self.tableView.reloadData()
    }
}

// MARK: - AccountTableViewCellDelegate

extension AccountsTableViewController: AccountTableViewCellDelegate {
    func didTapConfirm() {
        NotificationCenter.default.addObserver(forName: .accountDataLoaded, object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }
}
