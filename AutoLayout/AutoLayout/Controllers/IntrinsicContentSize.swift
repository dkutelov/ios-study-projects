//
//  IntrinsicContentSize.swift
//  AutoLayout
//
//  Created by Dariy Kutelov on 13.02.22.
//

import UIKit

class IntrinsicContentSize: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    func setupViews() {
        let label1 = BigLabel()
        label1.text = "Label 1"
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .white
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.textAlignment = .center
        
        label1.backgroundColor = .systemPink
        view.addSubview(label1)
        label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        
        label1.heightAnchor.constraint(equalToConstant: 350).isActive = true
        label1.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        //Overrides all width constrains
        label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
}

class BigLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 300)
    }
}
