//
//  ProfileCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var uploadImageview: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView?
    var postArray: [String] = []
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(user: imagensProfile){
        uploadImageview.image = UIImage(named: user.imagens)
    }
}
