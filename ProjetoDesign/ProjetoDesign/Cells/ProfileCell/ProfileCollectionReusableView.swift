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

    @IBOutlet var followButton: UIButton!
    var urlImage: String?
    var nameTap : (() -> ()) = {}
    // MARK: - Methods

    @IBAction func followButton(_ sender: Any) {
        nameTap()
    }
    func setup(user: Usuario){
        let uid = Auth.auth().currentUser?.uid

        if uid != user.userID {
            followButton.isHidden = false
        }
             nameLabel.text = user.name
             bioLabel.text = user.bio
             let url = URL(string: user.profileUrl)
            profileImageView.kf.setImage(with: url)

        if  user.following == 0 {
        followingCountLabel.text = "0"

        }else if let followingCount = user.following {
            followingCountLabel.text = "\(followingCount)"
            
        }
        if  user.followers == 0 {
            followersCountLabel.text = "0"

        }else if let followersCount = user.followers {
            followersCountLabel.text = "\(followersCount)"
        }

             bioLabel.adjustsFontSizeToFitWidth = true
             bioLabel.minimumScaleFactor = 0.5
             bioLabel.font = UIFont.systemFont(ofSize: 16)
             profileImageView.layer.maskedCorners = CACornerMask(
                 rawValue: UIRectCorner(
                     [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
                 ).rawValue
             )
        urlImage = user.profileUrl
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
