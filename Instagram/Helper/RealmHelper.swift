//
//  RealmHelper.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 19/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import Foundation
import UIKit

extension IndexPath {
    static func fromRow(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}

extension UICollectionView {
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
//        deleteItems(at: deletions.map(IndexPath.fromRow))
        insertItems(at: insertions.map(IndexPath.fromRow))
//        reloadItems(at: updates.map(IndexPath.fromRow))
    }
}
