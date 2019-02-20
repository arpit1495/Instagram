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
import RealmSwift

class HomeViewController: UIViewController {
  
  
  var postData: PostData?
  //var posts: [Post] = []
  
  
  @IBOutlet weak var postCollectionView: UICollectionView!
  
  private var items: Results<Post>?
  private var itemsToken: NotificationToken?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    items = Post.all()
    
    let realm = try! Realm()
    if realm.isEmpty{
      NetworkManager.get(fromUrl: URL(string: "https://jsonblob.com/api/4074c5dc-2dd1-11e9-8c29-6d3427129fcf")!, completion:
        {[unowned self] response in
          let json = JSON(response as Any)
          self.postData = Mapper<PostData>().map(JSONString: json.rawString()!)
          self.addPosts()
      })
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    itemsToken = items?.observe { [unowned self] changes in
      guard let collectionView = self.postCollectionView else { return }
      
      switch changes {
      case .initial:
        collectionView.reloadData()
      case .update(_, let deletions, let insertions, let updates):
        collectionView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
      case .error: break
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    itemsToken?.invalidate()
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
    let post = items?[indexPath.item]
    cell.post = post
    cell.postImage.image = nil
    NetworkManager.retrieveImage(for: (post?.imageUrl)!, completion: { [unowned self] response, url in
      if(url == post?.imageUrl){
        let image = response
        //post?.addImageData(data: image!.pngData()! as NSData)
        cell.postImage.image = image
        self.postCollectionView.reloadItems(at: [indexPath])
      }
    })
    return cell
  }
  
  func addPosts(){
    for i in 0...postData!.posts!.count - 6 {
      Post.add(post: (postData?.posts![i])!)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PostHeader", for: indexPath) as! PostHeaderView
    return headerView
  }
}

//flowlayout delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.size.width
    let post = items?[indexPath.item]
    guard let image = NetworkManager.getImageWithURLFromCache((post?.imageUrl)!) else{
      let height = CGFloat(248.50 + 64 + 60 + 76.5)
      return CGSize(width: width, height: height)
    }
    let ratio = image.size.width / image.size.height
    let photoHeight = width / ratio
    let height = photoHeight + 64 + 60 + 76.5
    return CGSize(width: width, height: CGFloat(height))
  }
  
  
}


