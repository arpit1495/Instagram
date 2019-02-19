//
//  NetworkManager.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 13/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class NetworkManager: NetworkProtocol {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    static func get(fromUrl url: URL, completion: @escaping (Any?) -> ()) {
        Alamofire.request(url.absoluteString).responseJSON { (response) in
            switch response.result {
            case .success (let responseObject):
                completion(responseObject)
                break
            case .failure:
                completion(nil)
                break
            }
        }
    }
    
    static func retrieveImage(for url: String, completion: @escaping (UIImage?, String) -> Void){
        
        if let cachedImage = self.imageCache.object(forKey: url as NSString) {
            print("inside if")
            completion(cachedImage, url)
        }else{
            Alamofire.request(url, method: .get).responseImage { (response) in
                switch response.result {
                case .success (let responseObject):
                    imageCache.setObject(responseObject, forKey: url as NSString)
                    completion(responseObject, url)
                    break
                    
                case .failure:
                    break
                    
                }
            }
        
        }
    }
}
