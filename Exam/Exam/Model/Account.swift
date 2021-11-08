//
//  Account.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import Foundation

struct Account: Codable {  
    var address: String
    var addressHash160: String
    var numberOfTransaction: Int
    var totalSent: Int
    var totalReceived: Int
    var balance: Int
}
