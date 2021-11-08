//
//  ReminderCell.swift
//  Reminders
//
//  Created by Dari Kutelov on 8.11.21.
//

import UIKit

class ReminderCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var isCompletedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func update(reminder: Reminder, index: Int) {
        titleLabel.text = reminder.title
        
        infoButton.tag = index
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mma"
        dateLabel.text = dateFormatter.string(from: reminder.date)
        
        isCompletedView.layer.borderColor = UIColor.lightGray.cgColor //covert from UI to CG
        isCompletedView.layer.cornerRadius = isCompletedView.frame.size.width / 2
        
        if reminder.isCompleted {
            isCompletedView.backgroundColor =  UIColor.green
            isCompletedView.layer.borderWidth = 0.0
        } else {
            isCompletedView.backgroundColor = UIColor.white
            isCompletedView.layer.borderWidth = 2.0
        }
    }
}
