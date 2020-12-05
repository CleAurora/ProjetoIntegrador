//
//  ProfileCollectionReusableView.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-27.
//

import UIKit
import FirebaseAuth
class ProfileCollectionReusableView: UICollectionReusableView {
    // MARK: - IBOtlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var postCountLabel: UILabel!
    @IBOutlet var followersCountLabel: UILabel!
    @IBOutlet var followingCountLabel: UILabel!
    
    
    // MARK: - Methods 
    func setup(user: Usuario){
        let uid = Auth.auth().currentUser?.uid
        if uid == user.userID {
            
             nameLabel.text = user.name
             bioLabel.text = user.bio
             let url = URL(string: user.profileUrl)
             profileImageView.kf.setImage(with: url)
            if let followingCount = user.following {
                followingCountLabel.text = "\(followingCount)"
            }else{
                followingCountLabel.text = "0"
            }
            if let followersCount = user.followers {
                followersCountLabel.text = "\(followersCount)"
            }else{
                followingCountLabel.text = "0"
            }
             
             
             bioLabel.adjustsFontSizeToFitWidth = true
             bioLabel.minimumScaleFactor = 0.5
             bioLabel.font = UIFont.systemFont(ofSize: 16)
             profileImageView.layer.maskedCorners = CACornerMask(
                 rawValue: UIRectCorner(
                     [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
                 ).rawValue
             )
        }

    }
    func setup(post: Post){
        profileImageView.image = UIImage(named: post.imageProfile)
        nameLabel.text = post.name
        bioLabel.text = post.comments
        profileImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
    }
}
