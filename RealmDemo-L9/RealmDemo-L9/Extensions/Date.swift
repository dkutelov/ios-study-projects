//
//  Date.swift
//  RealmDemo-L9
//
//  Created by Dari Kutelov on 4.11.21.
//

import Foundation

extension Date {
    var dateInISO8601: String {
        let dateFormater = ISO8601DateFormatter()
        dateFormater.formatOptions = [
            .withFullTime,
            .withTimeZone,
            .withFullDate,
            .withDashSeparatorInDate,
            .withFractionalSeconds
        ]
        
        return dateFormater.string(from: self)
    }
}
