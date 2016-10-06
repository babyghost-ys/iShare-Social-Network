//
//  PostCell.swift
//  iShare
//
//  Created by Peter Leung on 4/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernamelbl: UILabel!

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    
    @IBOutlet weak var likeslbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
