//
//  UserTableViewCell.swift
//  ApiDemo-L8
//
//  Created by Dari Kutelov on 4.11.21.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setAvatarImage(with imageUrlString: String?) -> Void {
        if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
            avatarImageView.sd_setImage(with: imageUrl)
        } else {
            avatarImageView.image = nil
        }
    }
    
    func setupWith(data: User) {
        
        usernameLabel.text = "\(data.firstName) \(data.lastName)"
    }

}
