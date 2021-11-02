//
//  SingletonExample.swift
//  ChecklistDemo
//
//  Created by Dari Kutelov on 31.10.21.
//

import UIKit

class LocationManager{
    
    static let shared = LocationManager()
    
    var locationGranted: Bool?
    //Initializer access level change now
    private init(){}
    
    func requestForLocation(){
        //Code Process
        locationGranted = true
        print("Location granted")
    }
}
