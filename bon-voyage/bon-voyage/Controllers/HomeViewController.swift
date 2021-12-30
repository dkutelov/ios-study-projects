//
//  HomeVC.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 30.12.21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginRegisterViewController = LoginRegisterViewController()
        loginRegisterViewController.modalPresentationStyle = .fullScreen
        present(loginRegisterViewController, animated: true)
    }
    

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
