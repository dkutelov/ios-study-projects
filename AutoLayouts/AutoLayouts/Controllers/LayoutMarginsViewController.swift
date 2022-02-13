//
//  LayoutMarginsViewController.swift
//  AutoLayouts
//
//  Created by Dariy Kutelov on 12.02.22.
//

import UIKit

class LayoutMarginsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        let leadingGuide = UILayoutGuide()
        let okButton = makeButton(title: "OK", color: .darkBlue)
        let middleGuide = UILayoutGuide()
        let cancelButton = makeButton(title: "Cancel", color: .darkGreen)
        let trailingGuide = UILayoutGuide()
     
        // Add subviews and layout guides
        view.addLayoutGuide(leadingGuide)
        view.addSubview(okButton)
        view.addLayoutGuide(middleGuide)
        view.addSubview(cancelButton)
        view.addLayoutGuide(trailingGuide)
        
        // setup constrains
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            //Pin margins - leadingGuide - okButton - middleGuide - cancelButton - trailingGuide
            margins.leadingAnchor.constraint(equalTo: leadingGuide.leadingAnchor),
            leadingGuide.trailingAnchor.constraint(equalTo: okButton.leadingAnchor),
            okButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor),
            middleGuide.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor),
            trailingGuide.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            //Equal Widths
            okButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor),
            //Vertical Position
            leadingGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            middleGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            trailingGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            okButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //Giving layout guides default height to avoid warning
            leadingGuide.heightAnchor.constraint(equalToConstant: 1),
            middleGuide.heightAnchor.constraint(equalToConstant: 1),
            trailingGuide.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    private func makeButton(title: String, color: UIColor) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.cornerStyle = .capsule // 2
        configuration.baseForegroundColor = UIColor.white
        configuration.buttonSize = .large
        configuration.contentInsets =  NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        configuration.baseBackgroundColor = color
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

}

extension UIColor {
    static let darkBlue = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1)
    static let darkGreen = UIColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1)
    static let darkOrange = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
    static let darkRed = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
    static let darkTeal = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
    static let darkYellow = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
}
