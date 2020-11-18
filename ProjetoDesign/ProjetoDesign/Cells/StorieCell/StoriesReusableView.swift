//
//  StoriesReusableView.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit
protocol HeaderDelegate {
    func doSomething()
}
class StoriesReusableView: UICollectionReusableView {
    @IBOutlet weak var currentUserImageView: UIImageView!
    @IBOutlet weak var borderView: BorderView!
    
    var delegate: HeaderDelegate?
    
    func teste(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        addGestureRecognizer(tapGesture)
    }
    @objc func headerViewTapped() {
        delegate?.doSomething()
    }
    func setup(user: Profile){
        currentUserImageView.image = UIImage(named: user.profileImage)
        //borderView.backgroundColor = UIColor(patternImage: UIImage(named: "stories2.jpg")!)
        
        
    }
}

