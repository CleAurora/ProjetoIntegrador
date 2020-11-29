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
    var imagensArray = [ImagensProfile]()
    
    // MARK: - Super Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupCollection()
        //setup()
        profileArray.append(Profile(name: "Melissa", profileImage: "mel0.jpg", bio: "It’s always important when preparing for your movie premiere to keep your neck napkin tucked in while you apply your press on nails"))
        
        imagensArray.append(ImagensProfile(imagens: "mel0.jpg", weatherImage: "sun"))
        imagensArray.append(ImagensProfile(imagens: "mel1.jpeg", weatherImage: "snowflake"))
        imagensArray.append(ImagensProfile(imagens: "mel2.jpg", weatherImage: ""))
        imagensArray.append(ImagensProfile(imagens: "melissa1.jpg", weatherImage: "snowflake"))
        imagensArray.append(ImagensProfile(imagens: "melissa2.jpeg", weatherImage: "cloud.rain"))
        imagensArray.append(ImagensProfile(imagens: "melissa3.jpg", weatherImage: ""))
        imagensArray.append(ImagensProfile(imagens: "melissa4.jpg", weatherImage: "cloud"))
        imagensArray.append(ImagensProfile(imagens: "melissa5.jpeg", weatherImage: "sun"))
        imagensArray.append(ImagensProfile(imagens: "melissa0.jpg", weatherImage: "cloud.rain"))

        profileCollectionView.reloadData()
    }
    
    // MARK: - Methods
    func setupCollection(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.reloadData()
    }
    func setup(){
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
