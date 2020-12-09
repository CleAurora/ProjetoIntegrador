//
//  UploadCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class UploadCollectionCell: UICollectionViewCell {
    // MARK: - IBOtlets
    @IBOutlet weak var uploadImageView: UIImageView!

    // MARK: - Methods 
    func setupImage(image: UIImage){
        uploadImageView.image = image
    }
}
