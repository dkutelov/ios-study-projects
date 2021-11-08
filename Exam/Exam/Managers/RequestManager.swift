//
//  RequestManager.swift
//  Exam
//
//  Created by Dari Kutelov on 6.11.21.
//

import Foundation
import Alamofire

enum NetworkErrors: Error {
    case cannotParseData
    case invalidAddress
}

class RequestManager {
    class func fetchDailyBlocks(completion: @escaping((_ error: Error?) -> Void)) {
        let date = Date()
        let calendar = Calendar.current
        let startTimeOfDayInMS = Int((calendar.startOfDay(for: date).timeIntervalSince1970 * 1000).rounded())
        let params: [String: String] = [
            "format": "json"
        ]
        
        let dailyBlocksUrl = "\(API.dailyBlocksUrl)/\(startTimeOfDayInMS)"
        
        AF.request(dailyBlocksUrl,
                   method: .get,
                   parameters: params)
            .responseJSON { result in
                guard result.error == nil else {
                    completion(result.error)
                    return
                }
                
                guard let resultValue = result.value else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                guard let blocksJSON = resultValue as? [[String: Any]] else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                var blocks = [Block]()
                
                for block in blocksJSON {
                    let blockData: [String: Any] = [
                        "blockHash": block["hash"] as? String ?? "",
                        "height": block["height"] as? Int ?? 0,
                        "time": block["time"] as? Int ?? 0,
                    ]
                    let block = Block(value: blockData)
                    blocks.append(block)
                }
                
                
                DispatchQueue.main.async {
                    try? LocalDataManager.realm.write {
                        LocalDataManager.realm.add(blocks, update: .all)
                    }
                    
                    NotificationCenter.default.post(name: .blocksDataLoaded, object: nil)
                }
                completion(nil)
            }
    }
    
    class func fetchBlockWith(blockHash: String, completion: @escaping((_ error: Error?) -> Void)) {
        let blockDetailsUrl = "\(API.blockDetailUrl)/\(blockHash)"
        
        AF.request(blockDetailsUrl,
                   method: .get)
            .responseJSON { result in
                guard result.error == nil else {
                    completion(result.error)
                    return
                }
                
                guard let resultValue = result.value else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                guard let blockJSON = resultValue as? [String: Any?] else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                DispatchQueue.main.async {
                    let existingBlock = LocalDataManager.realm.objects(Block.self).filter({ $0.blockHash == blockHash})
                    if let existingBlock = existingBlock.first {
                        try? LocalDataManager.realm.write {
                            existingBlock.mrklRoot = blockJSON["mrkl_root"] as? String ?? ""
                            existingBlock.nonce = blockJSON["nonce"] as? Int ?? 0
                            existingBlock.transactionsCount = blockJSON["n_tx"] as? Int ?? 0
                            existingBlock.hasDetails = true
                        }
                    }
                    
                    NotificationCenter.default.post(name: .blocksDatailsLoaded, object: nil)
                }
                
                completion(nil)
            }
    }
    
    class func fetchAccountWith(accountAddress: String, completion: @escaping((_ error: Error?) -> Void)) {
        let blockDetailsUrl = "\(API.accountUrl)/\(accountAddress)"
        
        AF.request(blockDetailsUrl,
                   method: .get)
            .responseJSON { result in
                guard result.error == nil else {
                    completion(result.error)
                    return
                }
                
                guard let resultValue = result.value else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                guard let accountJSON = resultValue as? [String: Any?] else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
               
                if let addressError = accountJSON["error"] {
                    if addressError as? String == "not-found-or-invalid-arg" {
                        completion(NetworkErrors.invalidAddress)
                    }
                    return
                }
                
                let account = Account(address: accountJSON["address"] as? String ?? "",
                                      addressHash160: accountJSON["hash160"] as? String ?? "",
                                      numberOfTransaction: accountJSON["n_tx"] as? Int ?? 0,
                                      totalSent:  accountJSON["total_sent"] as? Int ?? 0,
                                      totalReceived:  accountJSON["total_received"] as? Int ?? 0,
                                      balance:  accountJSON["final_balance"] as? Int ?? 0)
                
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(account)
                    let key = UserDefaultsData.currentAccountId
                    UserDefaults.standard.set(data, forKey: "\(key)")
                    UserDefaultsData.currentAccountId += 1
                } catch {
                    print("Unable to Encode Note (\(account))")
                }
                
                NotificationCenter.default.post(name: .accountDataLoaded, object: nil)
                
                completion(nil)
            }
    }
}
