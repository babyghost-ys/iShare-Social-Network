//
//  Posts.swift
//  iShare
//
//  Created by Peter Leung on 6/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import Foundation

class Posts {
    private var _caption: String!
    private var _imageUrl: String?
    private var _likes:Int!
    private var _postKey: String!
    
    var caption: String? {
        return _caption
    }
    
    var imageUrl:String?{
        return _imageUrl
    }
    
    var likes: Int{
        return _likes
    }
    
    var postkey: String{
        return _postKey
    }
    
    init(caption: String, imageURL: String, likes: Int) {
        self._caption = caption
        self._imageUrl = imageURL
        self._likes = likes
        
        
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        
        if let imageURL = postData["imageUrl"] as? String{
            self._imageUrl = imageURL
        }
        
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
    }

}
