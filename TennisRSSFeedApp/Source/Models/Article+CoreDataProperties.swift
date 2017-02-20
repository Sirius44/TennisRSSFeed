//
//  Article+CoreDataProperties.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import CoreData

extension Article {

    @NSManaged var title: String?
    @NSManaged var articleDesciption: String?
    @NSManaged var imageURL: String?
    @NSManaged var image: NSObject?
    @NSManaged var date: NSObject?
    @NSManaged var articleURL: String?

}
