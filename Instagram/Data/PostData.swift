//
//  PostData.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 12/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class PostData{
    var posts: [Post] = []
    
    init(){
        posts.append(Post(user: "Arpit", userImage: UIImage(named: "avatar")!, postImage: UIImage(named: "ucl")!, caption: "UCL is back"))
    }
}
