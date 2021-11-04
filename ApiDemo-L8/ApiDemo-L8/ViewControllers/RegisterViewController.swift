//
//  ViewController.swift
//  ApiDemo-L8
//
//  Created by Dari Kutelov on 3.11.21.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    // MARK - Lifecycle events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaultsData.userId != nil {
            performSegue(withIdentifier: K.registerToUsersSegueId, sender: self)
        }
        
        usernameTextField.becomeFirstResponder()
    }
    
    // MARK - IBActions
  
    @IBAction func usernameNextTapped(_ sender: UITextField) {
        usernameTextField.resignFirstResponder()
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func emailNextTapped(_ sender: UITextField) {
        emailTextField.resignFirstResponder()
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func passwordNextTapped(_ sender: UITextField) {
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.becomeFirstResponder()
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else { return }
        
        //username.contains(CharacterSet.alphanumerics)
//        email.filter { character in
//            character == "&"
//        }
        
        guard confirmPasswordTextField.text == password else { return }
        
        let newUser = User(id:"", username: username, email: email, password: password.hash.description, avatarUrl: generateAvatarUrl())
        
        RequestManager.createUser(user: newUser) { userId, error in
            
            UserDefaultsData.userId = userId
            
            //MARK: - Alert Controller Implementation
            
//            let messageContent = error?.localizedDescription ?? "Success"
//            let alertController = UIAlertController(title: "Result", message: messageContent, preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//                alertController.dismiss(animated: true) {[weak self] in
//                    self?.performSegue(withIdentifier: K.registerToUsersSegueId, sender: self)
//                }
//            }
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
            
            self.performSegue(withIdentifier: K.registerToUsersSegueId, sender: self)
        }
    }
    
    // MARK: - Helpers
    
    private func generateAvatarUrl() -> String {
        let avatarId = Int.random(in: 0...90)
        let gender = Int.random(in: 0...1) == 0 ? "women" : "men"
        let avatarURL = "\(K.avatarUrl)/\(gender)/\(avatarId).jpeg"
        return avatarURL
    }
}

