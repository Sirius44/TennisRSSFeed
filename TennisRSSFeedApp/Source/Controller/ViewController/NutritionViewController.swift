//
//  NutritionViewController.swift
//  TennisRSSFeedApp
//
//  Created by mac on 11/16/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import MobilePlayer

enum Destination {
    case nutrition
    case lessons
}

class NutritionViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var destination = Destination.nutrition
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleLabel.text = (destination == .lessons) ? "LESSONS" : "NUTRITION"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell") as! NutritionTableViewCell
        
        cell.videoPlayerButton.addTarget(self, action: #selector(NutritionViewController.palyVideo), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    
    func palyVideo(){
        let videoUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: "video", ofType: "mp4")!)
        let playerVC = MobilePlayerViewController(
            contentURL: videoUrl as URL,
            config: MobilePlayerConfig(
                dictionary: ["watermark": ["image": "MovielalaLogo"]]))
        playerVC.title = "Video Player"
        playerVC.activityItems = [videoUrl]
        presentMoviePlayerViewControllerAnimated(playerVC)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
