//
//  StoriesLoadedCollectionViewCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-18.
//

import UIKit
import Kingfisher
import Firebase

class StoriesLoadedCollectionViewCell: UICollectionViewCell {
    @IBOutlet var StoriesImage: UIImageView!
    @IBOutlet var ProfileImage: roundImageView!
    @IBOutlet var nameUser: UILabel!
    @IBOutlet var addNewItemButton: UIImageView!
    @IBOutlet var addNewStoriesButton: UIButton!
    

    var uid = Auth.auth().currentUser?.uid
    
    func setup(stories: StoriesModel){
        addNewItemButton.isHidden = true
        addNewStoriesButton.isHidden = true
        
        if let photo = stories.image {
            StoriesImage.kf.setImage(with: URL(string: photo))
        }
        if let profile = stories.imageProfile {
            ProfileImage.kf.setImage(with: URL(string: profile))
        }
        if let userID = uid {
            if userID == stories.userID {
                addNewItemButton.isHidden = false
                addNewStoriesButton.isHidden = false
            }
        }
        nameUser.text = stories.nameUser
    }
}
