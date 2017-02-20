//
//  NewsViewController.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/16/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import CoreData
@available(iOS 10.0, *)
class NewsFeedViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var context: NSManagedObjectContext!

    lazy var fetchedResultsController = NSFetchedResultsController<Article>()
    func frc() {
        
        let articlesFetchRequest:NSFetchRequest<Article> = Article.fetchRequest()
        articlesFetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
       
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: articlesFetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        // make sure the delegate is set to self
        self.fetchedResultsController.delegate = self
        
        do {
            try self.fetchedResultsController.performFetch()
            self.tableView.reloadData()
        } catch {
            print("Error performing initial fetch: \(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDel.managedObjectContext
        self.frc()
        
        self.reloadTableWithArticles()
 
    }
    
    func reloadTableWithArticles() {
        // Download new articles
        NetworkManager().fetchAllArticlesWithCompletion { (data, error) -> Void in
            
            if error != nil {
                // handle errors and return
                if let networkError = error as? NetworkError {
                    switch networkError{
                    case .networkFailure:
                        self.alertUserWithTitleAndMessage("Network Error", message: kNetworkFailureMessage)
                        return
                        
                    default:
                        self.alertUserWithTitleAndMessage("Unknown Error", message: kUnknownErrorMessage)
                        return
                    }
                }
            }
            
            if let unwrappedData = data as? Data {
                NetworkManager().parseAllArticleData(unwrappedData, completion: { (content, error) -> Void in
                    
                    if error == nil {
                        // Hop back on the main thread to reload, since we're in an async callback
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            do {
                                try self.fetchedResultsController.performFetch()
                                
                                self.tableView.reloadData()
                            } catch {
                                print("Error: \(error)")
                                // TODO: Core Data fetch failed, use prototype objects (content) returned
                            }
                        })
                    } else {
                        // handle error
                        if let networkError = error as? NetworkError {
                            switch networkError {
                            case .parsingError:
                                self.alertUserWithTitleAndMessage("Network Error", message: kParsingErrorMessage)
                                return
                                
                            default:
                                self.alertUserWithTitleAndMessage("Unknown Error", message: kUnknownErrorMessage)
                            }
                        }
                    }
                    
                })
            }
        }
    }

 // MARK: - Table view data source
    
 func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        print(self.fetchedResultsController.fetchedObjects?.count ?? "")
        return (self.fetchedResultsController.fetchedObjects?.count)!
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as! NewsFeedTableViewCell
    

    
    if let dataSource = self.fetchedResultsController.fetchedObjects {
      
        //cell.descriptionTitleLabel.text = dataSource.
        
//        let datas = NSArray(array: dataSource)
        let article = dataSource[indexPath.row]
        cell.descriptionTextView.text = article.articleDesciption
        cell.descriptionTitleLabel.text = article.title
        print(article.date ?? "")
       
        if let cellImage: UIImage = dataSource[(indexPath as NSIndexPath).row].image as? UIImage {
            cell.newsItemImageView.image = cellImage
        } else {
            cell.newsItemImageView.image = UIImage(named: "3.jpg")
        }
    }
    return cell
}
    
    
}

