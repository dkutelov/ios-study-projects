//
//  ImageLab.swift
//  AutoLayout
//
//  Created by Dariy Kutelov on 13.02.22.
//

import UIKit

class ImageLab: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    private func setupViews() {
        let image = makeImageView(named: "gaudi")
        let label = makeLabel(withText: "Title")
        let button = makeButton(withText: "Get Started")
    
        view.addSubview(image)
        view.addSubview(label)
        view.addSubview(button)
        
//        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        image.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        image.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 300),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    public func makeImageView(named imageName: String) -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: imageName)
    
        return view
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32)
        label.backgroundColor = .systemPink
        
        return label
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
