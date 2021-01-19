//
//  StoriesLoadedCollectionViewCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-18.
//

import UIKit
import Kingfisher
class StoriesLoadedCollectionViewCell: UICollectionViewCell {
    @IBOutlet var StoriesImage: UIImageView!
    
    func setup(stories: StoriesModel){
        if let photo = stories.image {
            StoriesImage.kf.setImage(with: URL(string: photo))
        }
    }
}
