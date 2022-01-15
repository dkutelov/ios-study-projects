//
//  ViewController+Ext.swift
//  Bon-voyage
//
//  Created by Dariy Kutelov on 15.01.22.
//

import UIKit

extension UIViewController {
    
    func simpleAlert(title: String? = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    func simpleSelfClosingAlert(title: String? = "Error", message: String, duration: Double? = 2.0) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.systemPink
        self.present(alert, animated: true)
        
        let when = DispatchTime.now() + duration!
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }
    }
}
