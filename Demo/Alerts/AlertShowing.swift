//
//  AlertShowing.swift
//  Demo
//
//  Created by Sajal Gupta on 12/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//
import UIKit

/// Allows conforming types to show alerts
protocol AlertShowing  { }

extension AlertShowing where Self: UIViewController {
    
    func showAlert(title: String = "Hint", body: String, action: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            action()
        }))
        self.present(alert, animated: true)
    }
}
