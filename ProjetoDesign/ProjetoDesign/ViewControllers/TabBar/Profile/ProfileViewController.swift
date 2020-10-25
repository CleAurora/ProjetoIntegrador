//
//  ProfileViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var profileArray = [Profile]()
    var imagensArray = [imagensProfile]()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupCollection()
        setup()
        imagensArray.append(imagensProfile(imagens: "mel0.jpg"))
        imagensArray.append(imagensProfile(imagens: "mel1.jpeg"))
        imagensArray.append(imagensProfile(imagens: "mel2.jpg"))
        imagensArray.append(imagensProfile(imagens: "post1.jpg"))
        imagensArray.append(imagensProfile(imagens: "post2.jpg"))
        imagensArray.append(imagensProfile(imagens: "post3.jpg"))
        imagensArray.append(imagensProfile(imagens: "mel0.jpg"))
        imagensArray.append(imagensProfile(imagens: "mel1.jpeg"))
        imagensArray.append(imagensProfile(imagens: "mel2.jpg"))
        imagensArray.append(imagensProfile(imagens: "post1.jpg"))
        imagensArray.append(imagensProfile(imagens: "post2.jpg"))
        imagensArray.append(imagensProfile(imagens: "post3.jpg"))
        imagensArray.append(imagensProfile(imagens: "mel0.jpg"))
        imagensArray.append(imagensProfile(imagens: "mel1.jpeg"))
        imagensArray.append(imagensProfile(imagens: "mel2.jpg"))
        imagensArray.append(imagensProfile(imagens: "post1.jpg"))
        imagensArray.append(imagensProfile(imagens: "post2.jpg"))
        imagensArray.append(imagensProfile(imagens: "post3.jpg"))

        profileCollectionView.reloadData()

        profileImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
    }
    func setupCollection(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.reloadData()
    }
    func setup(){
//        let profileUser = Profile(name: "Brendon", profileImage: "brendon.jpg")
        let profileUser = Profile(name: "Melissa", profileImage: "mel0.jpg")
        nameLabel.text = profileUser.name
        profileImageView.image = UIImage(named: profileUser.profileImage)
    }

}
extension ProfileViewController: UICollectionViewDelegate{
    
}
extension ProfileViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagensArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionCell
        cell.setup(user: imagensArray[indexPath.row])
        
        return cell
    }
    
    
}
