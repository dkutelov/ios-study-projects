//
//  LocationCell.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 15.11.21.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with location: Location) {
        address1Label.text = location.title
        address2Label.text = location.subtitle
    }
    
    func update(with searchResult: MKLocalSearchCompletion) {
        address1Label.text = searchResult.title
        address2Label.text = searchResult.subtitle
    }
}
