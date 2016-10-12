//
//  PostCell.swift
//  iShare
//
//  Created by Peter Leung on 4/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernamelbl: UILabel!

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    
    @IBOutlet weak var likeslbl: UILabel!
    
    var post: Posts!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(post: Posts, img: UIImage?){
        self.post = post
        self.caption.text = post.caption
        self.caption.dataDetectorTypes = .link
        
        if img != nil {
            self.postImg.image = img
        } else {
            if let imgURL = post.imageUrl {
                let REF = FIRStorage.storage().reference(forURL: imgURL)
                REF.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error == nil {
                        print("ok image")
                        if let imgData = data {
                            if let img = UIImage(data: imgData){
                                self.postImg.image = img
                                FeedViewController.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            }
                        }
                    }
                })
            }
        }
    }
}
