//
//  RegisterLoginViewController.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 15.01.22.
//

import UIKit
import JGProgressHUD

class RegisterLoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - IBActions
    
    @IBAction func loginButtonDidTapped(_ sender: RoundedButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonDidTapped(_ sender: Any) {
        
        // Validation
        guard let email = registerEmailTextField.text,
              !email.isEmpty,
              let password = registerPasswordTextField.text,
              !password.isEmpty,
              let confirmPassword = registerConfirmPasswordTextField.text,
              !confirmPassword.isEmpty else {
                  
                  // present alert
                  return
              }
        
        if password != confirmPassword {
            // present alert
            return
        }
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            UserManager.shared.registerUser(email: email, password: password) { error in
                self.activityIndicator.stopAnimating()
                
                if let error = error {
                    debugPrint(error.localizedDescription)
                    let hud = JGProgressHUD()
                    hud.textLabel.text = "\(error.localizedDescription)"
                    hud.indicatorView = JGProgressHUDIndicatorView()
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 3.0)
                    
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
