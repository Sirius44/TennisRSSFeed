//
//  BaseViewController.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/16/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickBackButton(_ sender: AnyObject) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSearchButton(_ sender: AnyObject) {
    }

    
}
