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
import RealmSwift
import Realm


@objcMembers class User: Object, Mappable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var avatarUrl = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatarUrl <- map["avatarUrl"]
    }
    
    
}

@objcMembers class Post: Object, Mappable {
    
    dynamic var user: User? = nil
    dynamic var id = 0
    dynamic var caption = ""
    dynamic var location = ""
    dynamic var likes = 0
    dynamic var comments = 0
    dynamic var imageUrl = ""
    dynamic var likeStatus = false
    
    override init(value: Any) {
        super.init(value: value)
        if let user = self.user{
            self.user = User(value: user)
        }
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    required init() {
       super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override static func primaryKey() -> String? {
        return "id"
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

extension Post{
    static let serialQueue = DispatchQueue(label: ".realm", qos: .userInitiated)
    
    static func all(in realm: Realm = try! Realm()) -> Results<Post> {
        return realm.objects(Post.self)
    }
    
    static func add(post: Post) {
        serialQueue.async {
            let realm: Realm = try! Realm()
            let item = post
            try! realm.write {
                realm.add(item, update: true)
            }
        }
    }

    
    func changeLikes(){
        let object = Post(value: self)
        Post.serialQueue.async { [unowned self] in
            let realm: Realm = try! Realm()
            try! realm.write {
                if(object.likeStatus){
                    object.likes -= 1
                    object.likeStatus = false
                }else{
                    object.likes += 1
                    object.likeStatus = true
                }
                realm.add(object, update: true)
            }
        }
    }
}
