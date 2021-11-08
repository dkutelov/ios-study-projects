//
//  BlockDetailTableViewController.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import UIKit

class BlockDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var merkleRootLabel: UILabel!
    @IBOutlet weak var numberOfTransactionsLabel: UILabel!
    @IBOutlet weak var nonceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var block: Block? {
        didSet {
            setupWithBlock()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let block = block {
            if block.hasDetails == false {
                activityIndicator.startAnimating()
            }
        }
        
        NotificationCenter.default.addObserver(forName: .blocksDatailsLoaded, object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                let blockData = LocalDataManager.realm.objects(Block.self).filter({ $0.blockHash == self.block?.blockHash})
                if let blockWithDetails = blockData.first {
                    self.block = blockWithDetails
                    self.activityIndicator.stopAnimating()
                    self.setupWithBlock()
                }
            }
        }
    }
    
    func setupWithBlock() {
        guard let block = self.block else {
            return
        }
        
        self.loadViewIfNeeded()
        
        self.hashLabel.text = block.blockHash
        self.heightLabel.text = block.height.description
        self.timeLabel.text =  Date(timeIntervalSince1970: TimeInterval(block.time)).dateInISO8601
        self.merkleRootLabel.text = block.mrklRoot
        self.numberOfTransactionsLabel.text = block.transactionsCount.description
        self.nonceLabel.text = block.nonce.description
    }
    
}
