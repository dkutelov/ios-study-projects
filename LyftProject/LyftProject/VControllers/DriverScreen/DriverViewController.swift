//
//  DriverViewController.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 6.12.21.
//

import UIKit
import MapKit

class DriverViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var etaLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carDriverImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var carLicenseLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    
    // MARK: - Properties
    
    var pickupLocation: Location!
    var dropoffLocation: Location!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        carLicenseLabel.layer.cornerRadius = 15.0
        carLicenseLabel.layer.borderColor = UIColor.gray.cgColor
        carLicenseLabel.layer.borderWidth = 1.0
        carLicenseLabel.clipsToBounds = true
        backButton.layer.cornerRadius = backButton.frame.size.width / 2.0
        
        // Seed data
        //let locations = LocationService.shared.getRecentLocations()
        //pickupLocation = locations[0]
        //dropoffLocation = locations[1]
        
        let (driver, eta) = DriverService.shared.getDriver(pickupLocation: pickupLocation)
        updateUI(driver: driver, eta: eta)
        
        addMapAnnotations(driver)
        
        mapView.delegate = self
        
        let driverLocation = Location(title: driver.name, subtitle: driver.licenseNumber, lat: driver.coordinate.latitude, lng: driver.coordinate.longitude)
        displayRoute(sourceLocation: driverLocation, destinationLocation: pickupLocation)
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editRideButtonDidTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    func updateUI(driver: Driver, eta: Int) -> Void {
        etaLabel.text = "ARIVES IN \(eta) MIN"
        driverNameLabel.text = driver.name
        carLicenseLabel.text = driver.car
        let ratingString =  String(format: "%.1f", driver.rating)
        ratingImageView.image = UIImage(named: "rating-\(ratingString)")
        ratingLabel.text = ratingString
        carImageView.image = UIImage(named: driver.car)
        carDriverImageView.image = UIImage(named: driver.thumbnail)
        carLicenseLabel.text = driver.licenseNumber
    }
    
    func addMapAnnotations(_ driver: Driver) {
        let driverAnnotation = VehicleAnnotation(coordinate: driver.coordinate)
        
        let pickupCoordinate = CLLocationCoordinate2D(latitude: pickupLocation.lat, longitude: pickupLocation.lng)
        let pickupAnnotation = LocationAnnotation(coordinate: pickupCoordinate, locationType: "pickup")
        
        let dropoffCoordinate = CLLocationCoordinate2D(latitude: dropoffLocation.lat, longitude: dropoffLocation.lng)
        let dropoffAnnotation = LocationAnnotation(coordinate: dropoffCoordinate, locationType: "dropoff")
        
        mapView.addAnnotations([driverAnnotation, pickupAnnotation, dropoffAnnotation])
        
        // Zoom view to fit all annotations
        let annotations: [MKAnnotation] = [driverAnnotation, pickupAnnotation, dropoffAnnotation]
        mapView.showAnnotations(annotations, animated: false)
    }
    
    private func displayRoute(sourceLocation: Location, destinationLocation: Location) {
        let sourceCoordinate = CLLocationCoordinate2D(latitude: sourceLocation.lat, longitude: sourceLocation.lng)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: destinationLocation.lat, longitude: destinationLocation.lng)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            if let error = error {
                print("There is an error with calculating route \(error)")
                return
            }
            
            guard let response = response else { return }
            
            let route = response.routes[0]
            // Add route to the map
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
}

// MARK: - MapKit Delegate

extension DriverViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseIdentifier = annotation is VehicleAnnotation ? K.VehicleAnnotation : K.LocationAnnotation
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        if annotation is VehicleAnnotation {
            annotationView?.image = UIImage(named: "car")
        } else if let locationAnnotation = annotation as? LocationAnnotation {
            annotationView?.image = UIImage(named: "dot-\(locationAnnotation.locationType)")
        }
        
        return annotationView
    }
    
    // Route display
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay) //easily mistaken with MKPolygoneRenderer
        // how thick
        renderer.lineWidth = 5.0
        renderer.strokeColor = UIColor(red: 247.0/255.0, green: 66.0/255.0, blue: 190.0/255.0, alpha: 1)
        return renderer
    }
}
