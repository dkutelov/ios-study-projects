//
//  StackViewDemoTwo.swift
//  AutoLayout
//
//  Created by Dariy Kutelov on 14.02.22.
//

import UIKit

class StackViewDemoTwo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    private func setupViews() {
        
        let stackView = makeStackView(withOrientation: .vertical)
        stackView.distribution = .fill
        
        let bigLabel = makeLabel(withText: "Big", size: 64, color: .darkYellow)
        let medLabel = makeLabel(withText: "Med", size: 32, color: .darkOrange)
        let smallLabel = makeLabel(withText: "Small", size: 8, color: .darkGreen)
        
        stackView.addArrangedSubview(medLabel)
        stackView.addArrangedSubview(bigLabel)
        stackView.addArrangedSubview(smallLabel)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}
