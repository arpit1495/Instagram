//
//  ViewController.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 08/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var storyImages = StoryData()
    var posts = PostData()
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = storyCollectionView.bounds.size.height
        let storyLayout = storyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        storyLayout.itemSize = CGSize(width: height, height: height)
        
        let postLayout = postCollectionView.collectionViewLayout as!UICollectionViewFlowLayout
        postLayout.estimatedItemSize = CGSize(width: view.frame.size.width, height: view.frame.size.width)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storyCollectionView{
            return 6
        }else{
            return 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
            cell.storyImage.image = storyImages.images![indexPath.item]
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.post = posts.posts[0]
            return cell
        }
        
    }   
    
}

