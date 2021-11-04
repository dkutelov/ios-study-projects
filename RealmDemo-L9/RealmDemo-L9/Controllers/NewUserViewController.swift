//
//  NewUserViewController.swift
//  RealmDemo-L9
//
//  Created by Dari Kutelov on 4.11.21.
//

import UIKit
import JGProgressHUD

class NewUserViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthDateDatePicker: UIDatePicker!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weigthTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var selectedGender: User.Gender {
        switch genderSegmentControl.selectedSegmentIndex {
        case 0:
            return .male
        case 1:
            return .female
        default:
            return .unknown
        }
    }
    
    
    func validateAndSaveData() {
        let birthDate = birthDateDatePicker.date // always has a date
        let gender = selectedGender
        
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let height = Double(heightTextField.text ?? ""),
              let weigth = Double(weigthTextField.text ?? "") else {
            
            let hud = JGProgressHUD()
            hud.textLabel.text = "Invalid Values"
            hud.indicatorView = JGProgressHUDIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
            
            return
        }
        
        DispatchQueue.main.async {
            let user = User()
            user.firstName = firstName
            user.lastName = lastName
            user.eBirthDate = birthDate
            user.eGender = gender
            user.height = height
            user.weight = weigth

//            Id in the user model - no need to wait for the id from firebase.
//            LocalDataManager.realm.beginWrite()
//            LocalDataManager.realm.add(user)
//            try? LocalDataManager.realm.commitWrite()
            
            RequestManager.uploadUser(user: user) { userId, error in
                // should be delegate
                
                if let userId = userId {
                    user.id = userId
                    
                    LocalDataManager.realm.beginWrite()
                    LocalDataManager.realm.add(user)
                    try? LocalDataManager.realm.commitWrite()
                }
               
                NotificationCenter.default.post(name: .userDataLoaded, object: nil)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - IBActions

    @IBAction func saveButtonTapped(_ sender: Any) {
        validateAndSaveData()
    }
}
