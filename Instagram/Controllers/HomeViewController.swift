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
    
    
    var postData: PostData?
    var posts: [Post] = []
    
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let height = storyCollectionView.bounds.size.height
//        let storyLayout = storyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        storyLayout.itemSize = CGSize(width: height, height: height)
//        
//        if let layout = postCollectionView?.collectionViewLayout as? PostLayout {
//            layout.delegate = self
//        }
        
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
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func addPosts(){
        var indexPath: [IndexPath] = []
        for i in 0...postData!.posts!.count - 10 {
            indexPath.append(IndexPath(item: posts.count, section: 0))
            posts.append((postData?.posts![i])!)
        }
        
        postCollectionView.insertItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PostHeader", for: indexPath) as! PostHeaderView
        return headerView
    }
}

//extension HomeViewController: PosttLayoutDelegate{
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
//        let post = posts[indexPath.item]
//        guard let image = post.image else{
//         return 248.50
//        }
//        let width = view.frame.size.width
//        let ratio = image.size.width / image.size.height
//        let height = width / ratio
//        return height
//    }
//}

//flowlayout delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width
        let post = posts[indexPath.item]
        guard let image = post.image else{
            let height = CGFloat(248.50 + 64 + 60 + 76.5)
            return CGSize(width: width, height: height)
        }
        let ratio = image.size.width / image.size.height
        let photoHeight = width / ratio
        let height = photoHeight + 64 + 60 + 76.5
        return CGSize(width: width, height: CGFloat(height))
    }

}

