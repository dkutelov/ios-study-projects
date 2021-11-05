//
//  CoinTableViewCell.swift
//  ExamPrep
//
//  Created by Dari Kutelov on 5.11.21.
//

import UIKit
import SDWebImage

class CoinTableViewCell: UITableViewCell {
    var coin: Coin? {
        didSet {
            if let coin = coin {
                setupWith(coin: coin)
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    // MARK: - Lifecycle Events
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Helpers
    private func setCoinImage(with imageUrl: String?) -> Void {
        if let imageUrl = imageUrl, let imageUrl = URL(string: imageUrl) {
            coinImageView.sd_setImage(with: imageUrl)
        } else {
            coinImageView.image = nil
        }
    }
    
    func setupWith(coin: Coin) -> Void {
        setCoinImage(with: coin.image)
        nameLabel.text = coin.name
        marketCapLabel.text = Double(coin.market_cap).formattedCurrency
        priceLabel.text = String(format: "$%0.2f", coin.current_price)
        percentChangeLabel.text = String(format: "(%0.2f%%)", coin.price_change_24h)
        percentChangeLabel.textColor = coin.price_change_24h >= 0 ? .systemGreen : .systemRed
    }
}
