//
//  Block.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import Foundation
import RealmSwift

class Block: Object {
    @Persisted var blockHash: String = ""
    @Persisted var height: Int  = 0
    @Persisted var time: Int = 0
    @Persisted var mrklRoot: String = ""
    @Persisted var nonce: Int  = 0
    @Persisted var transactionsCount: Int = 0
    @Persisted var hasDetails: Bool = false
    
    static override func primaryKey() -> String? {
        return "blockHash"
    }
}
