//
//  NetworkProtocol.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 13/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkProtocol {
    static func get(fromUrl url: URL, completion: @escaping (Any?) -> ())
    static func retrieveImage(for url: String, completion: @escaping (UIImage?, String) -> Void)
}
