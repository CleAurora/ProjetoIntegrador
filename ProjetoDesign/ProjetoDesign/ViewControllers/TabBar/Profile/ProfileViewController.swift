//
//  ProfileViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var tabBarView: UIView!
    
    // MARK: - Proprierts
    private lazy var viewModel: ProfileViewModel = ProfileViewModel(userModel: userModel, view: self, posts: postRequest)
    private lazy var userModel = ViewRequest()
    private lazy var postRequest = DownloadImages()

    // MARK: - Super Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarView.roundCorners(.topRight, radius: 33)
        navigationController?.navigationBar.isHidden = true
        getPost()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "activateTab"), object: .none)
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func settingButton(_ sender: Any) {
        viewModel.goNextView()
    }

    func getPost(){
        postRequest.loadData(completionHandler: { [weak self] success, _ in
            if success{
                self?.getData()
            }
        })
    }

    func getData(){
        userModel.loadData(completionHandler: { success, _ in
            if success {
                self.setupCollection()
            }
        })
    }
    // MARK: - Methods
    func setupCollection(){
        profileCollectionView.delegate = viewModel
        profileCollectionView.dataSource = viewModel
        profileCollectionView.reloadData()
    }
}

