//
//  Posts.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 12/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class Post{
    var user: String
    var userImage: UIImage
    var postImage: UIImage
    var caption: String
    
    init(user: String,
         userImage: UIImage,
         postImage: UIImage,
         caption: String){
        self.user = user
        self.userImage = userImage
        self.postImage = postImage
        self.caption = caption
    }
    
    convenience init(dictionary: NSDictionary) {
        let user = dictionary["user"] as! String
        let userImage = dictionary["userImage"] as! UIImage
        let postImage = dictionary["postImage"] as! UIImage
        let caption = dictionary["caption"] as! String
        
        self.init(user: user, userImage: userImage, postImage: postImage, caption: caption)
    }
}
