//
//  ViewController+Additions.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/17/16.
//  Copyright © 2016 admin. All rights reserved.
//
import UIKit


extension UIViewController {
    
    // Takes in title and message strings and presents a UIAletController
    func alertUserWithTitleAndMessage(_ title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
