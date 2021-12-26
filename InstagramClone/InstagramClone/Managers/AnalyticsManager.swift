//
//  AnalyticsManager.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 26.12.21.
//

import Foundation
import FirebaseAnalytics

final class AnaliticsManager {
    static let shared = AnaliticsManager()
    
    private init() {}
    
    func logEvents() {
        Analytics.logEvent("", parameters: [:])
    }
}
