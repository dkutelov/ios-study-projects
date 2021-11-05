//
//  RequestManager.swift
//  ExamPrep
//
//  Created by Dari Kutelov on 5.11.21.
//

import Foundation
import Alamofire

enum NetworkErrors: Error {
    case cannotParseData
}

class RequestManager {
    class func fetchAllMarketData(completion: @escaping((_ error: Error?) -> Void)) {
        let params: [String: String] = [
            "vs_currency": "usd",
            "order": "market_cap_desc",
            "per_page": "100"
        ]
        
        AF.request(API.marketsUrl, method: .get, parameters: params)
            .responseJSON { result in
                guard result.error == nil else {
                    completion(result.error)
                    return
                }
                
                guard let resultValue = result.value else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                guard let coinsJSON = resultValue as? [[String: Any]] else {
                    completion(NetworkErrors.cannotParseData)
                    return
                }
                
                
                let coins = coinsJSON.map({ Coin(value: $0)})
                
                DispatchQueue.main.async {
                    try? LocalDataManager.realm.write {
                        LocalDataManager.realm.add(coins, update: .all)
                    }
                    
                    NotificationCenter.default.post(name: .marketDataLoaded, object: nil)
                }
                
                completion(nil)
            }
    }
}
