//
//  LocationViewController.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 17.11.21.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var dropoffTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var locations = [Location]()
    var pickupLocation: Location?
    var dropoffLocation: Location?
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationService.shared.getRecentLocations()
        
        dropoffTextField.becomeFirstResponder()
        
        // delegates
        dropoffTextField.delegate = self
        searchCompleter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // show navigation bar; in Main.storybard select view controller and top bar -> Opaque Navigation Bar
        navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let routeViewController = segue.destination as? RouteViewController,
           let dropoffLocation = sender as? Location {
            routeViewController.pickupLocation = pickupLocation
            routeViewController.dropoffLocation = dropoffLocation
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func cancelDidTapped(_ sender: UIBarButtonItem) {
        // dismiss view controller in navigation
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TextField Delegate

extension LocationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let latestString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if latestString.count > 3 {
            searchCompleter.queryFragment = latestString
        }
        
        return true
    }
}

// MARK: - Table View DataSource

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.isEmpty ? locations.count : searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.locationCell) as! LocationCell
        
        if searchResults.isEmpty {
            let location = locations[indexPath.row]
            cell.update(with: location)
        } else {
            let searchResult = searchResults[indexPath.row]
            cell.update(with: searchResult)
        }
        
        return cell
    }
}

// MARK: - Table View Delegate

extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults.isEmpty {
            let dropoffLocation = locations[indexPath.row]
            performSegue(withIdentifier: SegueId.routeSegue, sender: dropoffLocation)
        } else {
            let searchResult = searchResults[indexPath.row]
            let searchRequest = MKLocalSearch.Request(completion: searchResult)
            let search = MKLocalSearch(request: searchRequest)
            search.start(completionHandler: {(response, error) in
                if error == nil {
                    if let dropoffPlacemark = response?.mapItems.first?.placemark {
                        let location = Location(placemark: dropoffPlacemark)
                        self.performSegue(withIdentifier: SegueId.routeSegue, sender: location)
                    }
                }
            })
        }
    }
}


// MARK: - MKLocalSearchCompleter Delegate

extension LocationViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
}
