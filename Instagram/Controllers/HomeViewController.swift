//
//  ViewController.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 08/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import AlamofireImage

class HomeViewController: UIViewController {
    
    var storyImages = StoryData()
    var postData: PostData?
    var posts: [Post] = []
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = storyCollectionView.bounds.size.height
        let storyLayout = storyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        storyLayout.itemSize = CGSize(width: height, height: height)
        
        if let layout = postCollectionView?.collectionViewLayout as? PostLayout {
            layout.delegate = self
        }
        
        NetworkManager.get(fromUrl: URL(string: "https://jsonblob.com/api/4074c5dc-2dd1-11e9-8c29-6d3427129fcf")!, completion:
            {[unowned self] response in
                let json = JSON(response as Any)
                self.postData = Mapper<PostData>().map(JSONString: json.rawString()!)
                self.addPosts()
        })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storyCollectionView{
            return 6
        }else{
            return posts.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
            cell.storyImage.image = storyImages.images![indexPath.item]
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            let post = posts[indexPath.item]
            cell.post = post
            guard let image = post.image else{
                NetworkManager.retrieveImage(for: post.imageUrl!, completion: {[unowned self] response in
                    let image = response
                    self.posts[indexPath.item].image = image
                    cell.postImage.image = image
                    self.postCollectionView.reloadItems(at: [indexPath])    
                })
                return cell
            }
            cell.postImage.image = image
            return cell
        }
    }
    
    func addPosts(){
        var indexPath: [IndexPath] = []
        for i in 0...postData!.posts!.count - 10 {
            indexPath.append(IndexPath(item: posts.count, section: 0))
            posts.append((postData?.posts![i])!)
        }
        
        postCollectionView.insertItems(at: indexPath)
    }
}

extension HomeViewController: PosttLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.item]
        guard let image = post.image else{
         return 248.50
        }
        let width = view.frame.size.width
        let ratio = image.size.width / image.size.height
        let height = width / ratio
        return height
    }
        
    
    
}

