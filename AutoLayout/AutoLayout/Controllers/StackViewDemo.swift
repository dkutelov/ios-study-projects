//
//  StackViewDemo.swift
//  AutoLayout
//
//  Created by Dariy Kutelov on 14.02.22.
//

import UIKit

class StackViewDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    private func setupView() {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0

        let buttonOne = makeButton(withText: "Button 1")
        let buttonTwo = makeButton(withText: "Button 2")
        let buttonThree = makeButton(withText: "Button 3")
        
        //Stack view derives its size from its content
        
        stackView.addArrangedSubview(buttonOne)
        stackView.addArrangedSubview(buttonTwo)
        stackView.addArrangedSubview(buttonThree)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        buttonOne.heightAnchor.constraint(equalToConstant: 50).isActive 
        = true
        buttonOne.widthAnchor.constraint(equalToConstant: 200).isActive = true

    }
    
    private func makeButton(withText text: String) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = text
        configuration.cornerStyle = .capsule // 2
        configuration.baseForegroundColor = UIColor.white
        configuration.buttonSize = .large
        configuration.contentInsets =  NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        configuration.baseBackgroundColor = .green
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
