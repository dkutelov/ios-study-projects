//
//  SignupViewController.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//

import UIKit
import SafariServices

class SignupViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Subviews
    
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45
        return imageView
    }()
    
    private let usernameField: InstagramTextField = {
        let field = InstagramTextField()
        field.placeholder = "Username"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
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
        field.placeholder = "Create Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()
    
    private let signupButton: InstagramButton = {
        let button = InstagramButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
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
    
    // MARK: - Properties
    public var completion: (() -> Void)?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create Account"
        view.backgroundColor = .systemBackground
        
        addSubviews()
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        addButtonActions()
        addImageGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = 90.0
        profilePictureImageView.frame = CGRect(
            x: (view.width - imageSize) / 2, //center horizontally
            y: view.safeAreaInsets.top + 15,
            width: imageSize,
            height: imageSize)
        
        usernameField.frame = CGRect(x: 25, y: profilePictureImageView.bottom+20, width: view.width-50, height: 50)
        emailField.frame = CGRect(x: 25, y: usernameField.bottom+10, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 50)
        signupButton.frame = CGRect(x: 25, y: passwordField.bottom+20, width: view.width-50, height: 50)
        termsButton.frame = CGRect(x: 25, y: view.height-120, width: view.width-50, height: 30)
        privacyButton.frame = CGRect(x: 25, y: termsButton.bottom+10, width: view.width-50, height: 30)
    }
    
    //MARK: - Private methods
    private func addSubviews() {
        view.addSubview(profilePictureImageView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signupButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addButtonActions() {
        signupButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    private func addImageGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(tap)
    }
    
    private func presentError() {
        let alert = UIAlertController(title: "Woops", message: "All fields shoud be filled! Password should be min 6 char long! Username should be alphanumeric!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    //MARK: - Actions
    @objc func didTapSignUp() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              username.trimmingCharacters(in: .alphanumerics).isEmpty, //trimming alphanumerics should reduce to empty
              username.count >= 2,
              password.count >= 6 else {
                  presentError()
                  return
              }
        
        let data = profilePictureImageView.image?.pngData()
        //Sign Up with authManager
        AuthManager.shared.signUp(
            email: email,
            username: username,
            password: password,
            profilePicture: data) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        UserDefaults.standard.setValue(user.email, forKey: "email")
                        UserDefaults.standard.setValue(user.username, forKey: "username")
                        
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.completion?()
                    case .failure(let error):
                        print("\n\n Sign Up Error: \(error)")
                    }
                }
            }
    }
    
    @objc func didTapTerms() {
        guard let url = URL(string: "https://www.instagram.com") else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
    
    @objc func didTapPrivacy() {
        guard let url = URL(string: "https://www.instagram.com") else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
    
    @objc func didTapImage() {
        print("image hover")
        let sheet = UIAlertController(title: "Profile Picture",
                                      message: "Set Your Profile Picture",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        present(sheet, animated: true)
    }
}


// MARK: - Text Field Delegate

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignUp()
        }
        
        return true
    }
}


// MARK: - Image Picker Delegate

extension SignupViewController:  UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        profilePictureImageView.image = image
    }
}
