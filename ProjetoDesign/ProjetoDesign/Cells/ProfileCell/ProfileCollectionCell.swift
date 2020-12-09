//
//  ProfileCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {

    // MARK: - IBOtlets
    @IBOutlet weak var uploadImageview: UIImageView?
    @IBOutlet weak var weatherImageView: UIImageView?

    // MARK: - Proprierts
    var postArray: [String] = []

    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Methods 
    func setup(post: DownloadPost){

        uploadImageview?.image = nil
        weatherImageView?.image = nil

        if post != nil {
            let url = URL(string: post.imagePost)
            uploadImageview?.kf.setImage(with: url)
        }

        //uploadImageview.image = UIImage(named: post.imagePost)
        //weatherImageView?.image = UIImage(named: user.weatherImage)
    }
}
