//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self, action: #selector(didTapClose)
        )
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
