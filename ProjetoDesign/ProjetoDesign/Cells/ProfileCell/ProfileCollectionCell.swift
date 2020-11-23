//
//  ProfileCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOtlets
    @IBOutlet weak var uploadImageview: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView?
    
    // MARK: - Proprierts
    var postArray: [String] = []
   
    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods 
    func setup(user: imagensProfile){
        uploadImageview.image = UIImage(named: user.imagens)
        weatherImageView?.image = UIImage(named: user.weatherImage)
    }
}
