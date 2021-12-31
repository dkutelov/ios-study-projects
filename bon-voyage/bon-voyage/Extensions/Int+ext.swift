//
//  Int+ext.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 31.12.21.
//

import Foundation

extension Int {
    func formatToCurrencyString() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.locale = Locale(identifier: "bg_BG")
        
        // need to cofnver to NSNumber
        let nsnum = NSNumber(integerLiteral: self / 100)
        return currencyFormatter.string(from: nsnum) ?? "$$$"
    }
}
