//
//  ViewController.swift
//  My Location
//
//  Created by Veronica Velkova on 27.09.20.
//

import UIKit
import CoreLocation
import CoreData

class CurrentLocationViewController: UIViewController {
    // MARK: - IBOutlet
    // This should be ready
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    // MARK: - Properties
    // TODO: - Add Location manager properties
    
    // TODO: - Add Reverse Geocoding properties
    
    // TODO: - Add CoreData
    
    
    var logoVisible = false
    
    lazy var logoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "Logo"),
                                  for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(getLocation),
                         for: .touchUpInside)
        button.center.x = self.view.bounds.midX
        button.center.y = 220
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "addLocation" {
            let controller = segue.destination
                as! LocationDetailsTableViewController
            // TODO: - Inject properties here
        }
    }
    
    // MARK: - IBAction
    @IBAction func getLocation() {
        // TODO: - Check permission
        
        // TODO: - Start/Stop location manager
    }
    
    // MARK:- Helper Methods
    private func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable location services for this app in Settings.",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func updateLabels() {
        // TODO: - Add more code here
    }
    
    private func setupGetButton() {
        // TODO: - Setup Button's Title
    }
    
    private func startLocationManager() {
        // TODO: - Start Location manager if enabled
    }
    
    private func stopLocationManager() {
        // TODO: - Stop Location manager
    }
}

// TODO: - Implement Location Manager Delegate
extension CurrentLocationViewController: CLLocationManagerDelegate {

}

extension CurrentLocationViewController {
    func showLogoView() {
        if !logoVisible {
            logoVisible = true
            containerView.isHidden = true
            view.addSubview(logoButton)
        }
    }
    
    func hideLogoView() {
        logoVisible = false
        containerView.isHidden = false
        logoButton.removeFromSuperview()
    }
    
}
