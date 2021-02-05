//
//  ProfileCollectionCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

final class ProfileCollectionCell: UICollectionViewCell {
    @IBOutlet weak var uploadImageview: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    
   
    // MARK: - Methods

    func setup(post: DownloadPost) {
        uploadImageview.image = nil
        weatherImageView.image = nil
        
        let url = URL(string: post.imagePost)
        uploadImageview.kf.setImage(with: url)
        

        if let weatherType = post.weatherype, !weatherType.isEmpty {
            weatherImageView.image = UIImage(named: weatherType)
        }
    }
}
