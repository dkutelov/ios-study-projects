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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationService.shared.getRecentLocations()
        
        dropoffTextField.becomeFirstResponder()
        // delegates
        dropoffTextField.delegate = self
        searchCompleter.delegate = self
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

// MARK: - TableView DataSource

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

// MARK: - MKLocalSearchCompleter Delegate

extension LocationViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
}
