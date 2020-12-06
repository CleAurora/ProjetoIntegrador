//
//  UserViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-23.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    // MARK: - Proprierts
    var post: PostUser?
    var images: [String] = []
    var userProfile: Usuario?
    
    var userModel = userSelectedrequest()
    var viewModel: UserCollectionDelegateDataSource?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        userModel.selectedUser = self.userProfile
        userModel.loadData(completionHandler: { success,_ in
            self.passDataThrough()
            print(success)
        })
    }
    func setupCollection(){
        profileCollectionView.delegate = viewModel
        profileCollectionView.dataSource = viewModel
        profileCollectionView.reloadData()
    }
    
    func passDataThrough(){
        self.viewModel = UserCollectionDelegateDataSource(userModel: userModel, view: self)
        self.viewModel?.useArrayTo(completionHandler: { success,_ in
            self.setupCollection()
            print(success)
        })
    }
}

// MARK: - Extensions 
//extension UserViewController: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(images[indexPath.row])
//        if let vc = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateInitialViewController() as? PhotoDetailViewController{
//            vc.name = post?.name
//            vc.comments = post?.comments
//            vc.image = images[indexPath.row]
//            vc.post = post
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
//}

