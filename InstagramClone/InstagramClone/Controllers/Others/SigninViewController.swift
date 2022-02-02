//
//  SigninViewController.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//

import UIKit
import SafariServices

class SigninViewController: UIViewController {
    
    private let headerView = SigninHeaderView()

    //MARK: - Subviews
    
    private let emailField: InstagramTextField = {
        let field = InstagramTextField()
        field.placeholder = "Email"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()

    private let passwordField: InstagramTextField = {
        let field = InstagramTextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()

    private let signinButton: InstagramButton = {
        let button = InstagramButton()
        button.setTitle("Sign In", for: .normal)
        return button
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Create Account", for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms of Service", for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy Policy", for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        addSubviews()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        addButtonActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: (view.height - view.safeAreaInsets.top) / 3)
        
        emailField.frame = CGRect(x: 25, y: headerView.bottom+20, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 50)
        signinButton.frame = CGRect(x: 25, y: passwordField.bottom+20, width: view.width-50, height: 50)
        createAccountButton.frame = CGRect(x: 25, y: signinButton.bottom+10, width: view.width-50, height: 30)
        termsButton.frame = CGRect(x: 25, y: view.height-120, width: view.width-50, height: 30)
        privacyButton.frame = CGRect(x: 25, y: termsButton.bottom+10, width: view.width-50, height: 30)
    }
    
    //MARK: - Private methods
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signinButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addButtonActions() {
        signinButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    private func presentError() {
        let alert = UIAlertController(title: "Woops", message: "All fields shoud be filled! Password should be min 6 char long! Username should be alphanumeric!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    //MARK: - Actions
    @objc func didTapSignIn() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
                  presentError()
                  return
              }
    }
    
    @objc func didTapCreateAccount() {
        let signupViewController = SignupViewController()
        signupViewController.completion = { [weak self] in
            DispatchQueue.main.async {
                let tabViewController = TabBarViewController()
                tabViewController.modalPresentationStyle = .fullScreen
                self?.present(tabViewController, animated: true)
            }
        }
        navigationController?.pushViewController(signupViewController, animated: true)
    }
    
    @objc func didTapTerms() {
        guard let url = URL(string: "https://www.instagram.com") else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
    
    @objc func didTapPrivacy(){
        guard let url = URL(string: "https://www.instagram.com") else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
}

// MARK: - Text Field Delegate

extension SigninViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        if textField == emailField {
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignIn()
        }
        
        return true
    }
}
