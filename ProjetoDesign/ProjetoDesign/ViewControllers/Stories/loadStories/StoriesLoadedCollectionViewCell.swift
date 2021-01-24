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
    @IBOutlet var ProfileImage: roundImageView!
    @IBOutlet var nameUser: UILabel!
    
    func setup(stories: StoriesModel){
        if let photo = stories.image {
            StoriesImage.kf.setImage(with: URL(string: photo))
        }
        if let profile = stories.imageProfile {
            ProfileImage.kf.setImage(with: URL(string: profile))
        }
        nameUser.text = stories.nameUser
    }
}
