//
//  InstagramTextField.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 28.12.21.
//

import UIKit

class InstagramTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) //inserts padding
        leftViewMode = .always
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        backgroundColor = .secondarySystemBackground //changes in light / dark mode
        autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
