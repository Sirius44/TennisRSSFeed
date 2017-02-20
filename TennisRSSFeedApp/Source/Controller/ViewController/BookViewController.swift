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
class BookViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!

    var bookItems:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookItems = [["title": "Title1", "price":"$2.99", "image": "1.img", "summary":"test test testetsetsetsesetsetsetsetsetsetsetsetsetsete testsetetst"]
                    ,["title": "Title2", "price":"$3.99", "image": "1.img", "summary":"test test testetsetsetsesetsetsetsetsetsetsetsetsetse testasfdasf"]];
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookItems.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        let item = bookItems.object(at: indexPath.row) as AnyObject
        
        cell.priceLabel.text = item["price"] as? String
        cell.titleLabel.text = item["title"] as? String
        cell.summaryTextView.text  = item["summary"] as? String
        
        return cell
    }
    
    
}

