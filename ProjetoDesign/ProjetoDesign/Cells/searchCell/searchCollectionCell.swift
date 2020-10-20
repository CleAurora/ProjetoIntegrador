//
//  searchCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class searchCollectionCell: UICollectionViewCell {
    @IBOutlet weak var usersImageview: roundImageView!
    
    func setup(user: Post){
        usersImageview.image = UIImage(named: user.imagePost)
    }
}
