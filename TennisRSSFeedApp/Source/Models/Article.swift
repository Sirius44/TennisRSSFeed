//
//  Article.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Article: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    convenience init(prototype: ArticlePrototype, inManagedObjectContext context: NSManagedObjectContext) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let entity = NSEntityDescription.entity(forEntityName: "Article", in: context)!
        
        self.init(entity: entity, insertInto: appDelegate.managedObjectContext)
        
        self.title = prototype.title
        self.articleDesciption = prototype.description
        self.imageURL = prototype.imageURL
        self.date = prototype.date as NSObject?
        self.articleURL = prototype.articleURL
        
        // optional image
        if let image = prototype.image as UIImage! {
            self.image = image
        }
    }

}
extension Article {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article");
    }
    
    @NSManaged var timeStamp: NSDate?
}
