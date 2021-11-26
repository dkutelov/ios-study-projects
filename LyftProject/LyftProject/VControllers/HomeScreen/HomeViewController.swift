//
//  HomeViewController.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 15.11.21.
//

import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: - Properties
    
    var locations = [Location]()
    var locationManager: CLLocationManager!
    var currentUserLocation: Location!
    
    //MARK: - Live Cicle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recentLocations = LocationService.shared.getRecentLocations()
        locations = [recentLocations[0], recentLocations[1]]
        
        // Location Manager
        setupLocationManager()
        
        // Add shadow to searchButton
        searchButton.backgroundColor = UIColor.white
        searchButton.layer.cornerRadius = 10.0
        searchButton.layer.shadowRadius = 1.0
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        searchButton.layer.shadowOpacity = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide navigation bar; also in view select navigation bar - none
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let locationViewController = segue.destination as? LocationViewController {
            locationViewController.pickupLocation = currentUserLocation
        } else if let routeViewController = segue.destination as? RouteViewController,
                    let dropoffLocation = sender as? Location {
            routeViewController.pickupLocation = currentUserLocation
            routeViewController.dropoffLocation = dropoffLocation
        }
    }
    
    // MARK: - Private methods
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
    
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - Table DataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.locationCell) as! LocationCell
        
        let location = locations[indexPath.row]
        cell.update(with: location)
        
        return cell
    }
    
    
}

// MARK: - Table View Delegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dropoffLocation = locations[indexPath.row]
        
        performSegue(withIdentifier: SegueId.routeSegue, sender: dropoffLocation)
    }
}

// MARK: - Location Manager

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let firstLocation = locations.first!
        currentUserLocation = Location(title: "Current Location", subtitle: "", lat: firstLocation.coordinate.latitude, lng: firstLocation.coordinate.longitude)
        print(firstLocation.coordinate.latitude, firstLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation() // saves battery
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - MapKit Delegate

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        // zoom in to the user location
        let distance = 1000.0
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        
        //3 vehicle annotations
        let lat = userLocation.coordinate.latitude
        let lng = userLocation.coordinate.longitude
        let offset = 0.000756
        let coord1 = CLLocationCoordinate2D(latitude: lat - offset, longitude: lng - offset)
        let coord2 = CLLocationCoordinate2D(latitude: lat, longitude: lng + offset)
        let coord3 = CLLocationCoordinate2D(latitude: lat, longitude: lng - offset)
        
        mapView.addAnnotations([
            VehicleAnnotation(coordinate: coord1),
            VehicleAnnotation(coordinate: coord2),
            VehicleAnnotation(coordinate: coord3),
        ])
    }
    
    // change annotation icon
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // do not chage for user
        if annotation is MKUserLocation {
            return nil
        }
        
        // Custom annotation view with vehicle image
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: K.VehicleAnnotation)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: K.VehicleAnnotation)
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "car")
        // rotationAngle is in radian
        annotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(arc4random_uniform(360) * 180) / CGFloat.pi)
        return annotationView
    }
}


