//
//  MainViewController.swift
//  BOLD
//
//  Created by admin on 6/3/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    

    @IBAction func MenuBtn(_ sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
    @IBAction func onClickMusicButton(_ sender: AnyObject) {
        let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "MusicViewController")
        self.navigationController?.pushViewController(musicVC!, animated: true)
    }
    
    @IBAction func onClickNewsButton(_ sender: AnyObject) {
        let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedViewController")
        self.navigationController?.pushViewController(musicVC!, animated: true)
    }
    
    @IBAction func onClickLessonsButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NutritionViewController") as? NutritionViewController
        vc?.destination = .lessons
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onClickNutritionButton(_ sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NutritionViewController") as? NutritionViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onClickShopButton(_ sender: AnyObject) {
        let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "ShopViewController")
        self.navigationController?.pushViewController(musicVC!, animated: true)
    }
}

