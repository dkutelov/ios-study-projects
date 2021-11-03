//
//  ChatTableViewCell.swift
//  CustomTableView-L7
//
//  Created by Dari Kutelov on 3.11.21.
//

import UIKit
import SDWebImage

protocol  ChatTableViewCellDelegate: AnyObject {
    func didTapEdit(cell: ChatTableViewCell)
    func didTabFavorite(cell: ChatTableViewCell)
}

class ChatTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var messageStatusView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileStatusView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imageLoadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: ChatTableViewCellDelegate?
    var chatMessage: ChatMessage?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLoadingActivityIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBActions
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.didTapEdit(cell: self)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let _ = chatMessage else {
            return
        }
        
        self.chatMessage?.isFavorite.toggle()
        
        delegate?.didTabFavorite(cell: self)
    }
    
    // MARK: - Helpers
    
    private func setDateLabel(from date: Date) -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true //since yesterday
        dateLabel.text = dateFormatter.string(from: date)
    }
    
    private func setProfileStatusBackground(profileStatus: ChatMessage.Status) -> Void {
        switch profileStatus {
        case .active:
            profileStatusView.backgroundColor = UIColor.green
        case .inactive:
            profileStatusView.backgroundColor = UIColor.lightGray
        }
    }
    
    private func setAvatar(with imageUrlString: String?) -> Void {
        if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
            avatarImageView.sd_setImage(with: imageUrl) { _ , _, _, _ in
                self.imageLoadingActivityIndicator.stopAnimating()
            }
        } else {
            avatarImageView.image = nil
            imageLoadingActivityIndicator.stopAnimating()
        }
    }
    
    private func setFavoriteButton(isFavorite: Bool) -> Void {
        switch isFavorite {
        case true:
            self.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        case false:
            self.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
    
    // MARK: - Functions
    
    func setupWith(data: ChatMessage){
        chatMessage = data
        titleLabel.text = data.name
        detailLabel.text = data.lastMessage
        setAvatar(with: data.avatar)
        setDateLabel(from: data.dateOfLastMessage)
        setProfileStatusBackground(profileStatus: data.profileStatus)
        messageStatusView.isHidden = data.unreadMessages == false
        setFavoriteButton(isFavorite: data.isFavorite)
    }
}
