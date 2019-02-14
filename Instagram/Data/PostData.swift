//
//  PostData.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 12/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class PostData: Mappable {
    var posts: [Post]?
    var timestamp: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        posts <- map["posts"]
        timestamp <- map["timestamp"]
    }
}
