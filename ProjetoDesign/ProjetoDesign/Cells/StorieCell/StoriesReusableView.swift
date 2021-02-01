//
//  StoriesReusableView.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit
// MARK: - Protocols
protocol HeaderDelegate {
    func doSomething()
}
class StoriesReusableView: UICollectionReusableView {
    // MARK: IBOutlets
    @IBOutlet weak var currentUserImageView: UIImageView!
    @IBOutlet weak var borderView: BorderView!
    @IBOutlet var addNewItemButton: UIButton!
    
    // MARK: - Proprierts
    var delegate: HeaderDelegate?

    // MARK: - Methods
    func teste(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        addGestureRecognizer(tapGesture)
    }
    // MARK: - OBJC Methods
    @objc func headerViewTapped() {
        delegate?.doSomething()
    }

    func setup(user: Profile){
        if user.profileImage.hasPrefix("https") {
            currentUserImageView.kf.setImage(with: URL(string: user.profileImage))
        } else {
            currentUserImageView.image = UIImage(named: user.profileImage)
        }
    }
}
