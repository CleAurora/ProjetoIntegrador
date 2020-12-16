//
//  searchCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit
import Kingfisher

class searchCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var usersImageview: roundImageView!

    // MARK: - Methods 
//    func setup(user: Post){
//        usersImageview.image = UIImage(named: user.imagePost)
//    }
    
    func setup(user: searchModel){
        let url = URL(string: user.imagePostUrl)
        usersImageview.kf.setImage(with: url)
    }
}
