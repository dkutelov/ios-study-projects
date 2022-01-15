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
        // Validation
        guard let email = loginEmailTextField.text,
              !email.isEmpty,
              let password = loginPasswordTextField.text,
              !password.isEmpty else {
                  simpleSelfClosingAlert(message: "All fields are required", duration: 2.0)
                  return
              }
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            UserManager.shared.loginUser(email: email, password: password) { error in
                
                defer { // defer - code will be executed in all cases when the function is exited
                    self.activityIndicator.stopAnimating()
                }
                
                if let error = error {
                    debugPrint(error.localizedDescription)
                    self.simpleSelfClosingAlert(message: "\(error.localizedDescription)", duration: 2.0)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func registerButtonDidTapped(_ sender: Any) {
        
        // Validation
        guard let email = registerEmailTextField.text,
              !email.isEmpty,
              let password = registerPasswordTextField.text,
              !password.isEmpty,
              let confirmPassword = registerConfirmPasswordTextField.text,
              !confirmPassword.isEmpty else {
                  simpleSelfClosingAlert(message: "All fields are required", duration: 2.0)
                  return
              }
        
        if password != confirmPassword {
            simpleSelfClosingAlert(message: "Passwords shound match", duration: 2.0)
            return
        }
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            UserManager.shared.registerUser(email: email, password: password) { error in
                
                defer { // defer - code will be executed in all cases when the function is exited
                    self.activityIndicator.stopAnimating()
                }
                
                if let error = error {
                    debugPrint(error.localizedDescription)
                    self.simpleSelfClosingAlert(message: "\(error.localizedDescription)", duration: 2.0)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
