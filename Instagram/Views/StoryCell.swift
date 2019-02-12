//
//  StoryCell.swift
//  Instagram
//
//  Created by Arpit Maheshwari on 11/02/19.
//  Copyright © 2019 Arpit Maheshwari. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImage: UIImageView!{
        didSet{
            storyImage.layer.cornerRadius = storyImage.bounds.size.height / 2
            storyImage.clipsToBounds = true
            storyImage.layer.borderWidth = 0
        }
    }
    
    @IBOutlet weak var storyLabel: UILabel!
}
