//
//  searchCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class searchCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var usersImageview: roundImageView!
    
    // MARK: - Methods 
    func setup(user: Post){
        usersImageview.image = UIImage(named: user.imagePost)
    }
}
