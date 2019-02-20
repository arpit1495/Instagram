//
//  SearchViewController.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 18/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import AlamofireImage

class SearchViewController: UIViewController {
    
    var storyImages = StoryData()
    
    var postData: PostData?
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let height = storyCollectionView.bounds.size.height
        let storyLayout = storyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        storyLayout.itemSize = CGSize(width: height, height: height)
        //storyCollectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                
        //prepare grid
        arrInstaBigCells.append(1)
        var tempStorage = false
        for _ in 1...21 {
            if(tempStorage){
                arrInstaBigCells.append(arrInstaBigCells.last! + 10)
            } else {
                arrInstaBigCells.append(arrInstaBigCells.last! + 8)
            }
            tempStorage = !tempStorage
        }
        
        photoGrid.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        photoGrid.contentOffset = CGPoint(x: -10, y: -10)
        
        if let layout = photoGrid?.collectionViewLayout as? GridLayout {
            layout.delegate = self
            layout.itemSpacing = 3
            layout.fixedDivisionCount = 3
        }
        
        NetworkManager.get(fromUrl: URL(string: "https://jsonblob.com/api/4074c5dc-2dd1-11e9-8c29-6d3427129fcf")!, completion:
            {[unowned self] response in
                let json = JSON(response as Any)
                self.postData = Mapper<PostData>().map(JSONString: json.rawString()!)
                self.addPosts()
        })

    }
    
    
    var arrInstaBigCells = [Int]()

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    @IBOutlet weak var photoGrid: UICollectionView!
}

//Delegate and datasource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storyCollectionView{
            return 6
        }else{
            return posts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storyCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchStory", for: indexPath) as! StoryCell
            cell.storyImage.image = storyImages.images![indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGrid", for: indexPath) as! PhotoGridCell
            let post = posts[indexPath.item]
            cell.image.image = nil
            let closureIndex = indexPath
            NetworkManager.retrieveImage(for: post.imageUrl, completion: {[unowned self] response, url in
                if(self.posts[indexPath.item].imageUrl == url && closureIndex.item == indexPath.item){
                    let image = response
                    cell.image.image = image
                    self.photoGrid.reloadItems(at: [indexPath])
                }
            })
            return cell
        }
    }
    
    
    func addPosts(){
        var indexPath: [IndexPath] = []
        for i in 0...postData!.posts!.count - 1 {
            indexPath.append(IndexPath(item: posts.count, section: 0))
            posts.append((postData?.posts![i])!)
        }
        
        photoGrid.insertItems(at: indexPath)
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            photoGrid.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            photoGrid.reloadData()
        }
    }
}

extension SearchViewController: GridLayoutDelegate{
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {
        if(arrInstaBigCells.contains(indexPath.row) || (indexPath.row == 1)){
            return 2
        } else {
            return 1
        }
    }
    
    func itemFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat {
        return fixedDimension
    }
}
