//
//  LoginRegisterViewController.swift
//  Bon-voyage
//
//  Created by Dari Kutelov on 30.12.21.
//

import UIKit

class LoginRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonDidTapped(_ sender: RoundedButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
