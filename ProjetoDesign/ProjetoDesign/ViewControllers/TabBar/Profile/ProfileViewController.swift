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
    var viewModel: ProfileViewModel?
    var userModel = ViewRequest()
    var imagensArray = [ImagensProfile]()
    
    // MARK: - Super Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imagensArray.append(ImagensProfile(imagens: "mel0.jpg", weatherImage: "sun"))
        imagensArray.append(ImagensProfile(imagens: "mel1.jpeg", weatherImage: "snowflake"))
        imagensArray.append(ImagensProfile(imagens: "mel2.jpg", weatherImage: ""))
        imagensArray.append(ImagensProfile(imagens: "melissa1.jpg", weatherImage: "snowflake"))
        imagensArray.append(ImagensProfile(imagens: "melissa2.jpeg", weatherImage: "cloud.rain"))
        imagensArray.append(ImagensProfile(imagens: "melissa3.jpg", weatherImage: ""))
        imagensArray.append(ImagensProfile(imagens: "melissa4.jpg", weatherImage: "cloud"))
        imagensArray.append(ImagensProfile(imagens: "melissa5.jpeg", weatherImage: "sun"))
        imagensArray.append(ImagensProfile(imagens: "melissa0.jpg", weatherImage: "cloud.rain"))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        self.userModel.loadData(completionHandler: { success, _ in
            if success {
                self.setupCollection()
            }
        })
    }
    // MARK: - Methods
    func setupCollection(){
        self.viewModel = ProfileViewModel(userModel: userModel, view: self)
        profileCollectionView.delegate = viewModel
        profileCollectionView.dataSource = viewModel
        profileCollectionView.reloadData()
    }
}
