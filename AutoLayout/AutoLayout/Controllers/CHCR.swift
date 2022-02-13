//
//  CHCR.swift
//  AutoLayout
//
//  Created by Dariy Kutelov on 13.02.22.
//

import UIKit

class CHCR: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    private func setupViews() {
        let nameLabel = makeLabel(withText: "Name")
        let myTextField = makeTextField(withPlaceholder: "Hellow World")
        
        view.addSubview(nameLabel)
        view.addSubview(myTextField)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            myTextField.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor),
            myTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            myTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
        
        // Set Higher Hugging prioriry for the other field to stretch, Not a constrain!
        nameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
    }

    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.backgroundColor = .systemPink
        
        return label
    }
    
    private func makeTextField(withPlaceholder text: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = text
        textField.backgroundColor = .green
        return textField
    }
}
