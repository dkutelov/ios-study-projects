//
//  AlbumViewController.swift
//  SpotifyClone
//
//  Created by Dariy Kutelov on 22.12.21.
//

import UIKit
import UIImageColors

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
        
       // album = CategoryService.shared.categories.first!.albums.randomElement()
        updateAlbum(with: album)
        setButtonsRadiusAndBorder()
        updateFollowingButton()
        
        thumbnailImageView.image?.getColors({ colors in
            if let primaryColor = colors?.primary.withAlphaComponent(0.8).cgColor {
                self.updateBackground(with: primaryColor)
            }
        })
        
        
    }
    
    //MARK: - Private methods
    private func setButtonsRadiusAndBorder() {
        shuffleButton.layer.cornerRadius = 10.0
        followButton.layer.cornerRadius = 5.0
        followButton.layer.borderWidth = 1.0
        followButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func updateFollowingButton() {
        if UserService.shared.isFollowingAlbum(album: album) {
            followButton.setTitle("Following", for: .normal)
            followButton.layer.borderColor = UIColor(red: 42.0 / 255.0, green: 183.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0).cgColor
            followButton.setTitleColor(UIColor(red: 42.0 / 255.0, green: 183.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0), for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.layer.borderColor = UIColor.white.cgColor
            followButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    private func updateAlbum(with album: Album) {
        thumbnailImageView.image = UIImage(named: album.image)
        titleLabel.text = album.name
        descriptionLabel.text = "\(album.followers) followers - by \(album.artist)"
    }
    
    private func updateBackground(with color: CGColor) {
        let backgroundColor = view.backgroundColor!.cgColor
        
        print(backgroundColor)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [backgroundColor, backgroundColor]
        gradientLayer.locations = [0.0, 0.4] // takes 0-1 and defines where gradient will stop
        
        // smoothen gradient by adding animation
        let gradientChangeColor = CABasicAnimation(keyPath: "colors") // keyPath is matching gradientLayer.colors
        gradientChangeColor.duration = 0.25
        gradientChangeColor.toValue = [color, backgroundColor]
        gradientChangeColor.isRemovedOnCompletion = false
        gradientChangeColor.fillMode = .forwards
        gradientLayer.add(gradientChangeColor, forKey: "colors")
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: - IBActions
    
    @IBAction func followButtonDidTapped(_ sender: UIButton) {
        if UserService.shared.isFollowingAlbum(album: album) {
            UserService.shared.unfollowAlbum(album: album)
        } else {
            UserService.shared.followAlbum(album: album)
        }
        updateFollowingButton()
        descriptionLabel.text = "\(album.followers) followers - by \(album.artist)"
    }
    
    @IBAction func backbuttonDidTapped(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
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
