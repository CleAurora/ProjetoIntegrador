//
//  UploadCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class UploadCollectionCell: UICollectionViewCell {
    @IBOutlet weak var uploadImageView: UIImageView!
    
    func setup(upload: Upload){
        uploadImageView.image = UIImage(named: upload.image)
    }
}
