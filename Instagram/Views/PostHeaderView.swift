//
//  PostHeaderView.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 15/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit

class PostHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var story: UICollectionView!
    var storyImages = StoryData()
}

extension PostHeaderView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
        cell.storyImage.image = storyImages.images![indexPath.item]
        
        return cell
    }
}

extension PostHeaderView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.size.height
        return CGSize(width: 0.8*height, height: height)
    }
}
