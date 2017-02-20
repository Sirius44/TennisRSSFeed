//
//  UserDetails.swift
//  TennisRSSFeedApp
//
//  Created by Adeel Miraj on 27/11/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import FirebaseAuth
import ObjectiveC

private var cityAssociationKey: UInt8 = 0

extension FIRUser {
    
    var city: String {
        get {
            guard let value = objc_getAssociatedObject(self, &cityAssociationKey) else {
                return ""
            }
            return value as! String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &cityAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

struct details {
    
    let city: String
//    let uid: String
    
    init(aCity: String) {//, UID: String) {
        city = aCity
//        uid = UID
    }
}


