//
//  RouteViewController.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 21.11.21.
//

import UIKit
import MapKit

class RouteViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var routeLabelsContainerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectRideButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var dropoffLabel: UILabel!
    
    // MARK: - Properties
    // Controller to work need to receive pickup and dropoff locations
    // Therefor these are explicitly unwrapped; better to crash then missing location
    var pickupLocation: Location!
    var dropoffLocation: Location!
    
    var rideQuotes = [RideQuote]()
    var selectedIndex = 1
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Rounding all corners
        routeLabelsContainerView.layer.cornerRadius = 10.0
        routeLabelsContainerView.layer.masksToBounds = true
        backButton.layer.cornerRadius = backButton.frame.size.width / 2.0
        backButton.layer.masksToBounds = true
        selectRideButton.layer.cornerRadius = 10.0
        selectRideButton.layer.masksToBounds = true
       
        // Populating properties for testging purposes
//        let locations = LocationService.shared.getRecentLocations()
//        pickupLocation = locations[0]
//        dropoffLocation = locations[1]
        
        pickupLabel.text = pickupLocation?.title
        dropoffLabel.text = dropoffLocation?.title
        
        rideQuotes = RideQuoteService.shared.getQuotes(pickupLocation: pickupLocation!, dropoffLocation: dropoffLocation!)
        
        // Add annotations to map view
        let pickupCoordinate = CLLocationCoordinate2D(latitude: pickupLocation!.lat, longitude: pickupLocation!.lng)
        let dropoffCoordinate = CLLocationCoordinate2D(latitude: dropoffLocation!.lat, longitude: dropoffLocation!.lng)
        
        let pickupAnnotation = LocationAnnotation(coordinate: pickupCoordinate, locationType: "pickup")
        let dropoffAnnotation = LocationAnnotation(coordinate: dropoffCoordinate, locationType: "dropoff")
        
        mapView.addAnnotations([pickupAnnotation, dropoffAnnotation])
        
        mapView.delegate = self
        
        displayRoute(sourceLocation: pickupLocation!, destinationLocation: dropoffLocation!)
     }
    
    func displayRoute(sourceLocation: Location, destinationLocation: Location) {
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
            
            // Zoom to the route
            let EDGE_INSET: CGFloat = 80.0 // Padding
            let boundingMapRect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(boundingMapRect, edgePadding: UIEdgeInsets(top: EDGE_INSET, left: EDGE_INSET, bottom: EDGE_INSET, right: EDGE_INSET), animated: true)
        }
    }
}

// MARK: - Table View Data Source

extension RouteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { rideQuotes.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.rideQuoteCell) as! RideQuoteCell
        
        let rideQuote = rideQuotes[indexPath.row]
        cell.update(rideQuote: rideQuote)
        cell.updateSelectedStatus(status: indexPath.row == selectedIndex)
        return cell
    }
}

// MARK: - Table View Delegate

extension RouteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let selectedRideQuote = rideQuotes[indexPath.row]
        selectRideButton.setTitle("Select \(selectedRideQuote.name)", for: .normal)
        tableView.reloadData()
    }
}

// MARK: - MapKit Delegate

extension RouteViewController: MKMapViewDelegate {
    // Change annotation icon
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: K.LocationAnnotation)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: K.LocationAnnotation)
        } else {
            annotationView!.annotation = annotation
        }
        
        let locationAnnotation = annotation as! LocationAnnotation
        annotationView?.image = UIImage(named: "dot-\(locationAnnotation.locationType)")
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
