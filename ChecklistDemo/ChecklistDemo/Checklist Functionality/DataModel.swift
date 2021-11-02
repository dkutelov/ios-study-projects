//
//  DataModel.swift
//  ChecklistDemo
//
//  Created by Dari Kutelov on 31.10.21.
//

import Foundation

class DataModel {
    private let indexOfSelectedItemKey="Checklistinndex"
    
    var checklists: [Checklist] = []
    var indexOfSelectedChecklist: Int {
        get {
            UserDefaults.standard.integer(forKey: indexOfSelectedItemKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: indexOfSelectedItemKey)
        }
    }
    
    class func nextChecklistItem() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    init() {
        loadChecklists()
    }
}

//MARK: - Save data

extension DataModel {
    
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklist() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(checklists)
            try data.write(to: dataFilePath(), options: .atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                checklists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
        
    }
}

