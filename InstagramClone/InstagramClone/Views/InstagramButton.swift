//
//  InstagramButton.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 28.12.21.
//

import UIKit

class InstagramButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
