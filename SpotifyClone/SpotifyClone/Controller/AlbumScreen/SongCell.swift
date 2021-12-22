//
//  SongCell.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 22.12.21.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func update(song: Song) {
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
}
