//
//  StorieCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class StorieCollectionCell: UICollectionViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var borderView: BorderView!
    
    func setup(storie: stories){
        myImageView.image = UIImage(named: storie.storieImageView)
        borderView.backgroundColor = UIColor(patternImage: UIImage(named: "stories2.jpg")!)
    }
    func user(storie: Profile){
        myImageView.image = UIImage(named: storie.profileImage)
        borderView.backgroundColor = UIColor(patternImage: UIImage(named: "stories2.jpg")!)
    }
}
