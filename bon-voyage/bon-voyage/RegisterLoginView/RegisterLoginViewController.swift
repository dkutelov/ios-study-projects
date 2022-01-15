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
                  showNotification(message: "Fields are required!", time: 1.0)
                  return
              }
        
        if password != confirmPassword {
            showNotification(message: "Password shoud match!", time: 1.0)
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
                    self.showNotification(message: "\(error.localizedDescription)", time: 3.0)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Private methods
    
    func showNotification(message text: String, time delay: Double) {
        let hud = JGProgressHUD()
        hud.textLabel.text = "\(text)"
        //hud.indicatorView = JGProgressHUDIndicatorView()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: delay)
    }
}
