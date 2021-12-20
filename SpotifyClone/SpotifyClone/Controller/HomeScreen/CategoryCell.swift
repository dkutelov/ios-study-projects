//
//  CategoryCell.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 20.12.21.
//

import UIKit

class CategoryCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categorySubtitleLabel: UILabel!
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    
    
    func update(category: Category, index: Int) {
        categoryTitleLabel.text = category.title
        categorySubtitleLabel.text = category.subtitle
        albumsCollectionView.tag = index //collection view is mapped to category
        albumsCollectionView.reloadData() // refresh data after new values are assigned
    }
}
