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
    let widthSize = Int.random(in: 195...200)
    let heightSize = Int.random(in: 195...244)
    
    // MARK: - Methods 
//    func setup(user: Post){
//        usersImageview.image = UIImage(named: user.imagePost)
//    }
    
    func setup(user: searchModel){
        let url = URL(string: user.imagePostUrl)
        usersImageview.kf.setImage(with: url)
       // usersImageview.frame = CGRect(x: 0, y: 0, width: widthSize, height: heightSize)
    }
}
