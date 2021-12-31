//
//  VacationDetailsViewController.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 31.12.21.
//

import UIKit

class VacationDetailsViewController: UIViewController {

    // MARK: - Properties

    var vacation: Vacation!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = vacation.title
    }

}
