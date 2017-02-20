//
//  CoreDataManager.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/17/16.
//  Copyright © 2016 admin. All rights reserved.
//
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    func cacheFetchedArticles(_ articles: [ArticlePrototype]) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var managedArray = [Article]()
        
        if #available(iOS 10.0, *) {
            let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
            do {
                let fetchedResults = try managedContext.fetch(fetchRequest)
                
                if let managedObjects = fetchedResults as [Article]! {
                    for managedObject in managedObjects {
                        managedContext.delete(managedObject)
                    }
                    
                    try managedContext.save()
                }
            } catch {
                // catch both the fetchRequest and save errors
                print("Error: \(error)")
            }

        } else {
            // Fallback on earlier versions
        }
        
        
        
        // now, save new articles
        
        for articleProto in articles {
            let managedArticle = Article(prototype: articleProto, inManagedObjectContext: managedContext)
            managedArray.append(managedArticle)
        }
        
        // save in core data
        do {
            try managedContext.save()
        } catch {
            print("Error: \(error)")
        }
      
        
    }
}
