//
//  ShopViewController.swift
//  TennisRSSFeedApp
//
//  Created by admin on 11/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ShopViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ShopCollectionView: UICollectionView!
    let Imagearray: NSMutableArray = ["Item1.png", "Item2.png", "Item3.png", "Item4.png"]
    let reuseIdentifier = "Shoppingcell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let col = UIColor(red: 234, green: 245, blue: 239, alpha: 0)
        self.ShopCollectionView?.backgroundColor = col
//        self.collectionView.registerClass(CollectionCell.self, forCellWithReuseIdentifier:reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return Imagearray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Shoppingcell",for: indexPath) as! ShopCollectionViewCell
        let imagename = Imagearray.object(at: indexPath.row)
        Cell.ImgItem.image = UIImage(named: imagename as! String)
        Cell.backgroundColor = UIColor.white
        //cell.backgroundColor = UIColor.black
        // Configure the cell
        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.size
        var itemSize = CGSize.init()
        itemSize.width  = (screenSize.width - 10) / 2.0
        itemSize.height = 1.29 * itemSize.width
        
        return itemSize
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    @IBAction func onClickBackButton(_ sender: AnyObject) {
//        let _ = self.navigationController?.popViewController(animated: true)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
