//
//  FavoriteViewController.swift
//  Reminders
//
//  Created by Dari Kutelov on 8.11.21.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    private func updateUI() {
        if let favoriteReminder = ReminderService.shared.getFavoriteReminder() {
            titleLabel.text = favoriteReminder.title
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy hh:mma"
            dateLabel.text = dateFormatter.string(from: favoriteReminder.date)
        }
    }    
}
