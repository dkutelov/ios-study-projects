//
//  AlbumCell.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 20.12.21.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    
    func update(album: Album) {
        tumbnailImageView.image = UIImage(named: album.image)
        titleLabel.text = album.name
        artistLabel.text = album.artist
        
    }
}
