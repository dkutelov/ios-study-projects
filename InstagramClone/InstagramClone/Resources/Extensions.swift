//
//  Extensions.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 27.12.21.
//

import Foundation
import UIKit

extension UIView {
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.origin.y + height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        frame.origin.x + width
    }
    
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
}