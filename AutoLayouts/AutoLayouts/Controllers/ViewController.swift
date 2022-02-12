//
//  ViewController.swift
//  AutoLayouts
//
//  Created by Dariy Kutelov on 12.02.22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        setupViews()
    }

    func setupViews() {
        let upperLeftLabel = makeLabel(withText: "Upper Left")
        let upperRightLabel = makeLabel(withText: "Upper Right")
        let bottomLeftLabel = makeSecondaryLabel(withText: "Bottom Left")
        let bottomRightButton = makeButton(withText: "Bottom Right")
        let middleView = makeView()
        
        // add to main view
        view.addSubview(upperLeftLabel)
        view.addSubview(upperRightLabel)
        view.addSubview(bottomLeftLabel)
        view.addSubview(bottomRightButton)
        view.addSubview(middleView)
        
        // pin Upper Left label to main view topAnchor
        // use safeAreaLayoutGuide to pin to safe area top/bottom
        upperLeftLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        upperLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        // Pin Upper Right Label
        upperRightLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        upperRightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        // Pin Bottom Left Label
        bottomLeftLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        bottomLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        // Pin Bottom Right Button
        bottomRightButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        bottomRightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        // Pin middle red view
        middleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        middleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // Option 1 Size explicitely
//        middleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        middleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        // Option 2 Size dynamically - mostly used
        middleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        middleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        middleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        middleView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    }
    
    // Label factory method
    func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        
        // For auto layout to work
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = text
        label.textColor = .white
        label.backgroundColor = .darkGray
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }
    
    //Secondary label
    func makeSecondaryLabel(withText text: String) -> UILabel {
        let label = UILabel()
        
        // For auto layout to work
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = text
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        
        label.backgroundColor = .darkGray
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }
    
    func makeButton(withText text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }
    
    func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }
}

