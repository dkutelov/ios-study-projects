//
//  VacationTableViewCell.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 30.12.21.
//

import UIKit
import SDWebImage

class VacationTableViewCell: UITableViewCell {
    
    //Mark: - IBOutlets
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Cell content view
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        
        // Card UIView
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = true
        cardView.layer.borderWidth = 0.5
        cardView.layer.borderColor = UIColor(named: "border_blue")?.cgColor
    }


    func configureCell(vacation: Vacation) {
        titleLabel.text = vacation.title
        priceLabel.text = vacation.price.formatToCurrencyString()
        
        if let imageUrl = vacation.images.first,
        let url = URL(string: imageUrl) {
            mainImage.sd_imageIndicator = SDWebImageActivityIndicator.medium //spinner when loading
            mainImage.sd_setImage(with: url, placeholderImage: UIImage(named: "background-beach-alpha"))
        }
    }
    
}
