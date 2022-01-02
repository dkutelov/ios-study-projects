//
//  VacationDetailsViewController.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 31.12.21.
//

import UIKit
import SDWebImage

class VacationDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activitiesLabel: UILabel!
    @IBOutlet weak var numberOfNightsLabel: UILabel!
    @IBOutlet weak var airfairLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Properties

    var vacation: Vacation!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - Private methods
    private func setupUI() {
        title = vacation.title
        
        // Gallery
        if let imageUrl = vacation.images.first {
           setMainImage(withUrl: imageUrl)
        }
        
        airfairLabel.text = vacation.airFare
        priceLabel.text = "All inclusive price: " + vacation.price.formatToCurrencyString()
        descriptionLabel.text = vacation.description
        activitiesLabel.text = vacation.activities
        numberOfNightsLabel.text = "\(vacation.numberOfDays) night accomodation"
    }
    
    private func setMainImage(withUrl imageUrl: String) {
        if let url = URL(string: imageUrl) {
            mainImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
            mainImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "background-beach-alpha"))
        } else {
            mainImageView.image = nil
        }
    }
}


// MARK: - Collection View Delegates
extension VacationDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vacation.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCell", for: indexPath) as! ThumbnailCollectionViewCell
        let url = vacation.images[indexPath.row]
        cell.configureCell(url: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      let tappedImageUrl = vacation.images[indexPath.row]
       setMainImage(withUrl: tappedImageUrl)
    }
}
