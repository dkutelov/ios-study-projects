//
//  Double.swift
//  ExamPrep
//
//  Created by Dari Kutelov on 5.11.21.
//

import Foundation

extension Double {
    var formattedCurrency: String {
        if Int(self) / 1000000000000 > 0 {
            return String(format: "$%0.3fT", self/1000000000000)
        }
        
        
        if Int(self) / 1000000 > 0 {
            return String(format: "$%0.3fB", self/1000000000)
        }
        
        if Int(self) / 1000000 > 0 {
            return String(format: "$%0.3fM", self/1000000)
        }

        if Int(self) / 1000 > 0 {
            return String(format: "$%0.3fK", self/1000)
        }

        return String(format: "$%0.2fK", self)
    }
    
    var formattedTo2Decimals: String {
        return String(format: "$%0.2f", self)
    }
}
