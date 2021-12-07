//
//  RideQuoteCell.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 21.11.21.
//

import UIKit

class RideQuoteCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var capaciltyLabel: UILabel!
    
    //MARK: - Methods
    func updateSelectedStatus(status: Bool) -> Void {
        if status {
            contentView.layer.cornerRadius = 5.0
            contentView.layer.masksToBounds = true
            contentView.layer.borderWidth = 2.0
            contentView.layer.borderColor = UIColor(red: 149.0/255.0, green: 67.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
        } else {
            contentView.layer.masksToBounds = true
            contentView.layer.borderWidth = 0.0
        }
    }
    
    func update(rideQuote: RideQuote) -> Void {
        thumbnailImageView.image = UIImage(named: rideQuote.thumbnail)
        titleLabel.text = rideQuote.name
        capaciltyLabel.text = rideQuote.capacity
        priceLabel.text = String(format: "$%.2f", rideQuote.price)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mma"
        timeLabel.text = dateFormatter.string(from: rideQuote.time)
    }

}
