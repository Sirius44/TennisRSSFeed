//
//  CustomTextField.swift
//  TennisRSSFeedApp
//
//  Created by Adeel Miraj on 24/11/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    var sublayer: CALayer?// = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
        addSublayer()
    }
    
    func addSublayer() {
        sublayer = CALayer.init()
        sublayer?.backgroundColor = UIColor.init(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 0.8).cgColor
        layer.addSublayer(sublayer!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var subFrame = frame
        subFrame.origin.y = frame.height - 1
        subFrame.size.height = 1.0
        
        sublayer?.frame = subFrame
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
