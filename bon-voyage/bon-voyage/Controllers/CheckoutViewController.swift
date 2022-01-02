//
//  CheckoutViewController.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 2.01.22.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var vacationTitle: UILabel!
    @IBOutlet weak var airfareLbl: UILabel!
    @IBOutlet weak var numberOfNightsLbl: UILabel!
    @IBOutlet weak var detailsPriceLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var processingFeeLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    @IBOutlet weak var selectCardView: UIView!
    @IBOutlet weak var cardIcon: UIImageView!
    @IBOutlet weak var cardEndingIn: UILabel!
    @IBOutlet weak var selectBankView: UIView!
    @IBOutlet weak var bankIcon: UIImageView!
    @IBOutlet weak var bankEndingIn: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var vacation: Vacation!
    var currentSelectedPaymentType: PaymentType?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapGestures()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        vacationTitle.text = vacation.title
        airfareLbl.text = vacation.airFare
        detailsPriceLbl.text = "All inclusive price: " + vacation.price.formatToCurrencyString()
        numberOfNightsLbl.text = "\(vacation.numberOfDays) nights accomodation"
        
        priceLbl.text = "Price: " + vacation.price.formatToCurrencyString()
    }
    
    private func setupTapGestures() {
        // UIView gesture recognizers
        let selectCardTouched = UITapGestureRecognizer(target: self, action: #selector(selectCardTapped))
        selectCardView.addGestureRecognizer(selectCardTouched)
        
        let selectBankTouched = UITapGestureRecognizer(target: self, action:                                                      #selector(selectBankTapped))
        selectBankView.addGestureRecognizer(selectBankTouched)
    }
    
    @objc func selectCardTapped() {
        if currentSelectedPaymentType == .card {return}
        
        currentSelectedPaymentType = .card
        
        selectCardView.layer.borderColor = UIColor(named: AppColor.borderBlue)?.cgColor
        selectCardView.layer.borderWidth = 2
        
        selectBankView.layer.borderColor = UIColor.lightGray.cgColor
        selectBankView.layer.borderWidth = 1
        
        cardIcon.tintColor = UIColor(named: AppColor.borderBlue)
        bankIcon.tintColor = UIColor.lightGray
    }
    
    @objc func selectBankTapped() {
        if currentSelectedPaymentType == .bank {return}
        
        currentSelectedPaymentType = .bank
        
        selectBankView.layer.borderColor = UIColor(named: AppColor.borderBlue)?.cgColor
        selectBankView.layer.borderWidth = 2
        
        selectCardView.layer.borderColor = UIColor.lightGray.cgColor
        selectCardView.layer.borderWidth = 1
        
        bankIcon.tintColor = UIColor(named: AppColor.borderBlue)
        cardIcon.tintColor = UIColor.lightGray
    }
}

enum PaymentType {
    case card
    case bank
}
