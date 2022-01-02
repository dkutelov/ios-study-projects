//
//  HomeVC.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 30.12.21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var vacations = [Vacation]()
    var selectedVacation: Vacation?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Vacation Packages"
        vacations = demoData
        setupTableView()
        
//        let loginRegisterViewController = LoginRegisterViewController()
//        loginRegisterViewController.modalPresentationStyle = .fullScreen
//        present(loginRegisterViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vacationDetailsViewController = segue.destination as? VacationDetailsViewController, let vacation = selectedVacation {
            vacationDetailsViewController.vacation = vacation
        }
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //gets rid of emtry cells at the end of the table
        tableView.contentInset.top = 8 // space above first cell
        tableView.register(UINib(nibName: "VacationTableViewCell", bundle: nil), forCellReuseIdentifier: "VacationCell")
    }
    
    
    // MARK: - IBActions
    
    @IBAction func userIconDidTapped(_sender: Any) {
        
        let userSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logout = UIAlertAction(title: "Logout", style: .default) { action in
            let loginRegisterViewController = LoginRegisterViewController()
            loginRegisterViewController.modalPresentationStyle = .fullScreen
            self.present(loginRegisterViewController, animated: true)
        }
        
        let manageCards = UIAlertAction(title: "Manage Credit Cards", style: .default) { action in
            //display stripe widget
        }
        
        let manageBanks = UIAlertAction(title: "Manage Bank Accounts", style: .default) { action in
            //manage accounts
        }
        
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        userSheet.addAction(manageCards)
        userSheet.addAction(manageBanks)
        userSheet.addAction(logout)
        userSheet.addAction(close)
        
        present(userSheet, animated: true)
    }
}

// MARK: Table View Datasource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VacationCell", for: indexPath) as! VacationTableViewCell
        cell.configureCell(vacation: vacations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

// MARK: Table View Datasource

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVacation = vacations[indexPath.row]
        performSegue(withIdentifier: "VacationDetails", sender: self)
    }
}
