//
//  BaseViewController.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// Use to check subclass deallocation
    deinit {
        print("\(String(describing: self)) dealloacated")
    }
}
