//
//  CoinDetailTableViewController.swift
//  ExamPrep
//
//  Created by Dari Kutelov on 5.11.21.
//

import UIKit

class CoinDetailTableViewController: UITableViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameDataLabel: UILabel!
    @IBOutlet weak var priceDataLabel: UILabel!
    @IBOutlet weak var marketCapDataLabel: UILabel!
    @IBOutlet weak var marketCapRankDataLabel: UILabel!
    @IBOutlet weak var symbolDataLabel: UILabel!
    @IBOutlet weak var totalVolumeDataLabel: UILabel!
    @IBOutlet weak var h24DataLabel: UILabel!
    @IBOutlet weak var L24DataLabel: UILabel!
    @IBOutlet weak var priceChangeDataLabel: UILabel!
    @IBOutlet weak var priceChangePercentDataLabel: UILabel!
    @IBOutlet weak var circulatingSUpplyDataLabel: UILabel!
    @IBOutlet weak var totalSupplyDataLabel: UILabel!
    
    
    // MARK: - Properties
    var coin: Coin? {
        didSet {
            setupWithCoin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    func setupWithCoin() {
        guard let coin = coin else {
            return
        }
    
        self.loadViewIfNeeded()
        nameDataLabel.text = coin.name
        priceDataLabel.text = coin.current_price.formattedTo2Decimals
        marketCapDataLabel.text = Double(coin.market_cap).formattedCurrency
        marketCapRankDataLabel.text = coin.market_cap_rank.description
        symbolDataLabel.text = coin.symbol
        totalVolumeDataLabel.text = Double(coin.total_volume).formattedCurrency
        h24DataLabel.text = String(format: "$%0.2f", coin.high_24h)
        L24DataLabel.text =  String(format: "$%0.2f", coin.low_24h)
        priceChangeDataLabel.text = coin.price_change_24h.formattedTo2Decimals
        priceChangePercentDataLabel.text = coin.price_change_percentage_24h.formattedTo2Decimals
        circulatingSUpplyDataLabel.text = coin.circulating_supply.description
        totalSupplyDataLabel.text = coin.total_supply?.description ?? "-"
    }

}
