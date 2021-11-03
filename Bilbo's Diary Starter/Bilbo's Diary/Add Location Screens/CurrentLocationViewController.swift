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
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var updatingLocation = false
    var lastLocationError: Error?
    
    // Geocoding properties
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lestGeocodingError: Error?
    
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
            controller.coordinate = location!.coordinate
            controller.placemark = placemark
        }
    }
    
    // MARK: - IBAction
    @IBAction func getLocation() {
        // TODO: - Check permission
        let authStatus = CLLocationManager.authorizationStatus()
        
        guard authStatus != .notDetermined else {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        // TODO: - Start/Stop location manager

        guard authStatus != .denied && authStatus != . restricted else {
            showLocationServicesDeniedAlert()
            return
        }
        
        if logoVisible {
            hideLogoView()
        }
        
        if updatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
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
        if let location = location {
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.isHidden = false
            messageLabel.text = ""
            
            if let placemark = placemark {
                addressLabel.text = """
                        \(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? "") \(placemark.locality ?? "") \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")
                    """
            } else if performingReverseGeocoding {
                addressLabel.text = "Still searching ..."
            } else if lastLocationError != nil {
                addressLabel.text = "Error finding address."
            } else {
                addressLabel.text = "No address found!"
            }
            
        } else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            tagButton.isHidden = true
            addressLabel.text = ""
            
            var statusMessage: String
            
            if let error = lastLocationError as NSError? {
                if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                    statusMessage = "Location Service Disabled!"
                } else {
                    statusMessage = "Error Getting Location!"
                }
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Service Disabled!"
            } else if updatingLocation {
                statusMessage = "Searching ..."
            } else {
                statusMessage = ""
                showLogoView()
            }
            
            messageLabel.text = statusMessage
        }
        
        setupGetButton()
    }
    
    private func setupGetButton() {
        if updatingLocation {
            getButton.setTitle("Stop", for: .normal)
        } else {
            getButton.setTitle("Get My Location", for: .normal)
        }
    }
    
    private func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters //the higher -> less precision
            locationManager.startUpdatingLocation()
            updatingLocation = true
            updateLabels()
        }
    }
    
    private func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
            updateLabels()
        }
    }
}

// TODO: - Implement Location Manager Delegate
extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        location = newLocation
        lastLocationError = nil
        
        updateLabels()
        
        if !performingReverseGeocoding {
            print("Start reverse geocoding!")
            performingReverseGeocoding = true
            
            geocoder.reverseGeocodeLocation(newLocation) { placemarks, error in
                if let error = error {
                    print("error in reverse geocoding: \(error)")
                }
                
                if let places = placemarks {
                    print("Found Places: \(places)")
                    self.performingReverseGeocoding = false
                    self.placemark = places.last
                }
                
                self.stopLocationManager()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
        lastLocationError = error
        
        updateLabels()
    }

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
