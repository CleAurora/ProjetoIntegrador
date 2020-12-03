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
    func setup(upload: Upload){
        uploadImageView.image = UIImage(named: upload.image)
    }
    func setupImage(image: UIImage){
        print(image)
        uploadImageView.image = image
    }
}
