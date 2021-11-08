//
//  NewAccountViewController.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import UIKit
import JGProgressHUD

protocol  AccountTableViewCellDelegate: AnyObject {
    func didTapConfirm()
}


class NewAccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var accountAddressTextField: UITextField!
    
    // MARK: - Properties
    
    weak var delegate: AccountTableViewCellDelegate?
    
    // MARK: - Lifecycle events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountAddressTextField.
    }
    
    // MARK: - IBActions
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        if let accountAddress = accountAddressTextField.text, !accountAddress.isEmpty {
            
            RequestManager.fetchAccountWith(accountAddress: accountAddress) { error in
                
                if error != nil {
                    let hud = JGProgressHUD()
                    hud.textLabel.text = "Invalid Address"
                    hud.indicatorView = JGProgressHUDIndicatorView()
                    hud.show(in: self.view)
                    hud.dismiss(afterDelay: 3.0)
                } else {
                    self.delegate?.didTapConfirm()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
