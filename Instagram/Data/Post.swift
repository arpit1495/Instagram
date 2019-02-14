//
//  Posts.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 12/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class User: Mappable {
    var id: Int?
    var name: String?
    var avatarUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatarUrl <- map["avatarUrl"]
    }
    
    
}

class Post: Mappable {
    
    
    var user: User?
    var id: Int?
    var caption: String?
    var location: String?
    var likes: Int?
    var comments: Int?
    var imageUrl: String?
    var likeStatus: Bool?
    var image: UIImage?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        id <- map["id"]
        caption <- map["caption"]
        location <- map["location"]
        likes <- map["likes"]
        comments <- map["comments"]
        imageUrl <- map["imageUrl"]
        likeStatus <- map["likeStatus"]
    }
}
