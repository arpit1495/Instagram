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
            userImage.layer.cornerRadius = userImage.bounds.size.height / 2
            userImage.clipsToBounds = true
            userImage.layer.borderWidth = 0
            
            if(post?.likeStatus ?? false){
                likeButton.setImage(UIImage(named: "heart"), for: .normal)
            }else{
                likeButton.setImage(UIImage(named: "like"), for: .normal)
            }
            likesLabel.text = "♥ \(String(describing: post!.likes!)) likes"
        }
    }
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func toogleLike(_ sender: Any) {
        post?.likeStatus = !(post?.likeStatus)!
        if(post?.likeStatus ?? false){
            likeButton.setImage(UIImage(named: "heart"), for: .normal)
            post?.likes! += 1
            likesLabel.text = "♥ \(String(describing: post!.likes!)) likes"
        }else{
            likeButton.setImage(UIImage(named: "like"), for: .normal)
            post?.likes! -= 1
            likesLabel.text = "♥ \(String(describing: post!.likes!)) likes"
        }
    }
}

