//
//  MenuViewController.swift
//  BOLD
//
//  Created by admin on 6/4/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MenuViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var locationBtn: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = FIRAuth.auth()?.currentUser
        //locationLabel.text = user?.city
        nameLabel.text = user?.displayName
        
        let userRef = FIRDatabase.database().reference(withPath: "user-details").child((user?.uid)!)
        userRef.observe(.value, with: { (snapshot) in
            
//            let snapshotValue = snapshot.value as! [String: AnyObject]
//            let city = snapshotValue["city"] as! String
//            user?.city = city
//            self.locationLabel.text = city
        })
    }

    @IBAction func OnClickedBtnHome(_ sender: AnyObject) {
            hideSideMenuView()
    }
    
    @IBAction func onClickSignBtn(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            
            let initialController = mainStoryboard.instantiateViewController(withIdentifier: "InitialViewController")
            present(initialController, animated: true, completion: {
                UIApplication.shared.keyWindow?.rootViewController = initialController
            })
        } catch {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
