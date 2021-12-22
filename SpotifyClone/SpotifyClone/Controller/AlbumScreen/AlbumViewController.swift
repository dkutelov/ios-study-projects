//
//  AlbumViewController.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 22.12.21.
//

import UIKit

class AlbumViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    
    // MARK: - Properties
    var album: Album!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        album = CategoryService.shared.categories.first!.albums.randomElement()
        updateAlbum(album: album)
        setButtonsRadiusAndBorder()
    }
    
    // Private methods
    private func setButtonsRadiusAndBorder() {
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 1.0
        followButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func updateAlbum(album: Album) {
        thumbnailImageView.image = UIImage(named: album.image)
        titleLabel.text = album.name
        descriptionLabel.text = "\(album.followers) followers - by \(album.artist)"
    }
}

// MARK: - Table view data source

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let songCell = tableView.dequeueReusableCell(withIdentifier: K.songCell) as? SongCell else {
            return UITableViewCell()
        }
        
        let song = album.songs[indexPath.row]
        songCell.update(song:song)
        return songCell
    }
}
