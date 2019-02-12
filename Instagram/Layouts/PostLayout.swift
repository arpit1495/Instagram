//
//  PostLayout.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 11/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit

protocol PostLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPostImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class PostLayoutAttributes: UICollectionViewLayoutAttributes {
    
    
}


class PostLayout: UICollectionViewLayout {
    
}
