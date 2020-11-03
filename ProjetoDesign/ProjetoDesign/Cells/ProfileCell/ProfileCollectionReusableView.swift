//
//  ProfileCollectionReusableView.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-27.
//

import UIKit

class ProfileCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(post: Profile){
        profileImageView.image = UIImage(named: post.profileImage)
        nameLabel.text = post.name
        bioLabel.text = post.bio
        //bioLabel.adjustsFontSizeToFitWidth = true
        //bioLabel.minimumScaleFactor = 0.5
        //bioLabel.font = UIFont.systemFont(ofSize: 25)
        profileImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
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
