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
        profileImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
    }
}
