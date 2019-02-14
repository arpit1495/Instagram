//
//  NetworkManager.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 13/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager: NetworkProtocol {
    
    private static let imageCache = NSCache< NSString, NSData>()
    
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
    
    static func retrieveImage(for url: String, completion: @escaping (UIImage?) -> Void){
        
        if let data = self.imageCache.object(forKey: NSString(string: url)){
            let image = UIImage(data: data as Data)
            completion(image)
        }else{
            Alamofire.request(url, method: .get).responseImage { (response) in
                switch response.result {
                case .success (let responseObject):
                    completion(responseObject)
                    if let data = response.data as NSData?{
                        imageCache.setObject( data, forKey: NSString(string: url))
                    }
                    break
                    
                case .failure:
                    break
                    
                }
            }
        
        }
    }
}
