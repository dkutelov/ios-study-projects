//
//  Date.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
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
