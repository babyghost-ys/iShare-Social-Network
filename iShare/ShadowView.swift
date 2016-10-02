//
//  ShadowView.swift
//  iShare
//
//  Created by Peter Leung on 2/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit

@IBDesignable

class ShadowView: UIView {

    @IBInspectable var shadowRadi:CGFloat = 5.0
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: Shadow_Gray, green: Shadow_Gray, blue: Shadow_Gray, alpha: Shadow_Gray).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = shadowRadi
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
