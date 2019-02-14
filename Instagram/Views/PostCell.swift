//
//  PostCell.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 11/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit
import AlamofireImage

class PostCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            userName.text = post?.user?.name
            userImage.af_setImage(withURL: URL(string: (post!.user?.avatarUrl)!)!)
//            postImage.af_setImage(withURL: URL(string: (post?.imageUrl)!)!)
            captionLabel.text = post?.caption
        }
    }
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIImageView!
    @IBOutlet weak var commentButton: UIImageView!
    @IBOutlet weak var shareButton: UIImageView!
}

