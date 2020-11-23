//
//  ProfileViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: - Proprierts
    var profileArray = [Profile]()
    var imagensArray = [imagensProfile]()
    
    // MARK: - Super Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupCollection()
        //setup()
        profileArray.append(Profile(name: "Melissa", profileImage: "mel0.jpg", bio: "It’s always important when preparing for your movie premiere to keep your neck napkin tucked in while you apply your press on nails"))
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

        /*profileImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )*/
    }
    
    // MARK: - Methods
    func setupCollection(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.reloadData()
    }
    func setup(){
//        let profileUser = Profile(name: "Brendon", profileImage: "brendon.jpg")
        let profileUser = Profile(name: "Melissa", profileImage: "mel0.jpg", bio: "")
        nameLabel.text = profileUser.name
        profileImageView.image = UIImage(named: profileUser.profileImage)
    }

}

// MARK: - Extensions 
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
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileReuCell", for: indexPath) as! ProfileCollectionReusableView
        cell.setup(post: profileArray[indexPath.row])
        return cell
    }
    
    
}
