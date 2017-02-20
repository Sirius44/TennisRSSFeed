//
//  NutritionTableViewCell.swift
//  TennisRSSFeedApp
//
//  Created by mac on 11/16/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class NutritionTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSubView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var favoriteView: UIView!
    @IBOutlet var shareView: UIView!
    @IBOutlet var videoPlayerButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBoarderOfView(ofView: cellSubView, borderWidth: 0.5, borderColor: UIColor.clear, cornerRadius: 5.0)
        setBoarderOfView(ofView: favoriteView, borderWidth: 0.5, borderColor: UIColor.gray, cornerRadius: 5)
        setBoarderOfView(ofView: shareView, borderWidth: 0.5, borderColor: UIColor.gray, cornerRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBoarderOfView(ofView: UIView, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        ofView.layer.borderColor = borderColor.cgColor
        ofView.layer.cornerRadius = cornerRadius
        ofView.layer.borderWidth = borderWidth
    }

}
