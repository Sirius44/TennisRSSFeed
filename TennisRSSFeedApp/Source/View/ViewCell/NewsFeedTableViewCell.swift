//
//  NewsFeedTableViewCell.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var itemSubView: UIView!
    @IBOutlet weak var newsItemImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var loveBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    @IBOutlet weak var loveCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setBoarderOfView(ofView: readMoreBtn, borderWidth: 0.5, borderColor: UIColor.clear, cornerRadius: 5.0)
        setBoarderOfView(ofView: loveBtn, borderWidth: 0.5, borderColor: UIColor.black, cornerRadius: 5.0)
        setBoarderOfView(ofView: shareBtn, borderWidth: 0.5, borderColor: UIColor.black, cornerRadius: 5.0)
        setBoarderOfView(ofView: itemSubView, borderWidth: 0.5, borderColor: UIColor.clear, cornerRadius: 5.0)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tappedLoveBtn(_ sender: AnyObject) {
    }

    @IBAction func tappedShareBtn(_ sender: AnyObject) {
    }

    @IBAction func tappedReadMoreBtn(_ sender: AnyObject) {
    }
    
    func setBoarderOfView(ofView: UIView, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        ofView.layer.borderColor = borderColor.cgColor
        ofView.layer.cornerRadius = cornerRadius
        ofView.layer.borderWidth = borderWidth
    }

}
