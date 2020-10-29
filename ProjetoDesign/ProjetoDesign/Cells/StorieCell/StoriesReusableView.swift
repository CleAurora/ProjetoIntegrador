//
//  StoriesReusableView.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit

class StoriesReusableView: UICollectionReusableView {
    @IBOutlet weak var currentUserImageView: UIImageView!
    @IBOutlet weak var borderView: BorderView!
    
    func setup(user: Profile){
        currentUserImageView.image = UIImage(named: user.profileImage)
        //borderView.backgroundColor = UIColor(patternImage: UIImage(named: "stories2.jpg")!)
        
        
    }
}

