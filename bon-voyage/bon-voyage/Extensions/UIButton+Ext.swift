//
//  UIButton+Ext.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 31.12.21.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
