//
//  ThumbnailCollectionViewCell.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 2.01.22.
//

import UIKit
import SDWebImage

class ThumbnailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func configureCell(url: String) {
        if let url = URL(string: url) {
            thumbnailImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
            thumbnailImage.sd_setImage(with: url, placeholderImage: UIImage(named: "background-beach-alpha"))
        }
    }
}
