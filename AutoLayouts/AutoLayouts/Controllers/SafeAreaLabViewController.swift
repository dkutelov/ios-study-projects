//
//  SafeAreaLabViewController.swift
//  AutoLayouts
//
//  Created by Dariy Kutelov on 12.02.22.
//

import UIKit

class SafeAreaLabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    private func setupViews() {
        let topLabel = makeLabel(withText: "TOP")
        let bottomLabel = makeLabel(withText: "BOTTOM")
        let leadingLabel = makeLabel(withText: "LEADING")
        let trailingLabel = makeLabel(withText: "TRAILING")
        
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        view.addSubview(leadingLabel)
        view.addSubview(trailingLabel)
        
        NSLayoutConstraint.activate([
            // Pin Top Label
            topLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8),
            // without safeAreaLayoutGuide is not visible
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            // Pin Bottom Label
            bottomLabel.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -8),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //Pin Leading - safeAreaLayoutGuide is optional for leading and trailing - no difference
            leadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            leadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //Pin Trailing
            trailingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            trailingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        
        // For auto layout to work
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32)
        label.backgroundColor = .darkGray
        return label
    }
    
}
