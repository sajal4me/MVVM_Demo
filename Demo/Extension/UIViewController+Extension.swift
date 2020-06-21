//
//  UIViewController+Extension.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import UIKit

extension UIViewController {
    
     var activityIndicatorTopViewTag: Int { return 9999990 }
    
    func startActivityIndicator(
        style: UIActivityIndicatorView.Style = .medium,
           location: CGPoint? = nil) {
           
           //Set the position - defaults to `center` if no`location`
           
           //argument is provided
           
           let loc = location ?? view.center
           
           //Ensure the UI is updated from the main thread
           
           //in case this method is called from a closure
           DispatchQueue.global().async {
               DispatchQueue.main.async {
                   let topView = UIView()
                   topView.frame = self.view.frame
                   topView.tag = self.activityIndicatorTopViewTag
                   let activityIndicator = UIActivityIndicatorView(style: style)
                   activityIndicator.center = loc
                   activityIndicator.hidesWhenStopped = true
                   //Start animating and add the view
                   
                   activityIndicator.startAnimating()
                   topView.addSubview(activityIndicator)
                   
                   self.view.addSubview(topView)
               }
           }
       }
       
       func stopActivityIndicator() {
           DispatchQueue.global().async {
               DispatchQueue.main.async {
                   if let topView = self.view.subviews.filter(
                   { $0.tag == self.activityIndicatorTopViewTag}).first  {
                       topView.removeFromSuperview()
                   }
               }
           }
       }
}
