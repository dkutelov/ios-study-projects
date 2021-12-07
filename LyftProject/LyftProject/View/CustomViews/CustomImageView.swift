//
//  CustomImageView.swift
//  LyftProject
//
//  Created by Dariy Kutelov on 6.12.21.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
           didSet {
               self.layer.borderWidth = borderWidth
           }
       }
       
       @IBInspectable var borderColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {
           didSet {
               self.layer.borderColor = borderColor.cgColor
           }
       }
}
