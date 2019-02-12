//
//  PostCell.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 11/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            userImage.image = post?.userImage
            userName.text = post?.user
            postImage.image = post?.postImage
            userImage.layer.cornerRadius = userImage.bounds.size.height / 2
            userImage.clipsToBounds = true
            userImage.layer.borderWidth = 0
        }
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
}

