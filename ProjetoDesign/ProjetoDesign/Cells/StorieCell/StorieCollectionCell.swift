//
//  StorieCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class StorieCollectionCell: UICollectionViewCell {
    @IBOutlet weak var myImageView: UIImageView!
   
    func setup(storie: stories){
        myImageView.image = UIImage(named: storie.storieImageView)
    }
}
