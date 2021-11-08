//
//  BlocksTableViewCell.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import UIKit

class BlockTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    var block: Block? {
        didSet {
            if let block = block {
                setupWith(block: block)
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
    
    private func setupWith(block: Block) {
        self.textLabel?.text = block.height.description
        self.detailTextLabel?.text = Date(timeIntervalSince1970: TimeInterval(block.time)).dateInISO8601
        
    }
}
