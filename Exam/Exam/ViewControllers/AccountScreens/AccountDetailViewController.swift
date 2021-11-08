//
//  AccountDetailViewController.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import UIKit

class AccountDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressHash160Label: UILabel!
    @IBOutlet weak var numberOfTransactionsLabel: UILabel!
    @IBOutlet weak var totalSentLabel: UILabel!
    @IBOutlet weak var totalReceivedLabel: UILabel!
    @IBOutlet weak var finalBalanceLabel: UILabel!
    
    // MARK: - Properties
    
    var account: Account? {
        didSet {
            setupWithBlock()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    func setupWithBlock() {
        guard let account = self.account else {
            return
        }
        
        self.loadViewIfNeeded()
        
        self.addressLabel.text = account.address
        self.addressHash160Label.text = account.addressHash160
        self.numberOfTransactionsLabel.text = account.numberOfTransaction.description
        self.totalSentLabel.text = account.totalSent.description
        self.totalReceivedLabel.text = account.totalReceived.description
        self.finalBalanceLabel.text = account.balance.description
    }
    
}
