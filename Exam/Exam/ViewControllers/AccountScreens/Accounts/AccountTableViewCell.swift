//
//  AccountTableViewCell.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var account: Account? {
        didSet {
            if let account = account {
                setupWith(account: account)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helpers
    
    private func setupWith(account: Account) {
        self.textLabel?.text = account.address
        self.detailTextLabel?.text = account.balance.description
    }
    
}
