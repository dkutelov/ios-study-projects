//
//  RoundedView.swift
//  CustomTableView-L7
//
//  Created by Dari Kutelov on 3.11.21.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
            if isCircle {
                self.layer.cornerRadius = self.frame.width / 2
                self.layer.masksToBounds = true
            }
        }
    }
}

