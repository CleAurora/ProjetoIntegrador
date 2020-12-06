//
//  UserViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-23.
//

import UIKit
import FirebaseAuth
class UserViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    // MARK: - Proprierts
    var post: PostUser?
    var images: [String] = []
    var isFollowing: Bool?
    var userProfile: Usuario?
    
    var followModel = FollowRequest()
    var userModel = userSelectedrequest()
    var viewModel: UserCollectionDelegateDataSource?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getData()
//        configureButtonFollow()
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.getData()
        configureButtonFollow()
    }
    
    func getData(){
        userModel.selectedUser = self.userProfile
        userModel.loadData(completionHandler: { success,_ in
            self.passDataThrough()
            print(success)
        })
    }
    
    func getFollowers(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        followModel.userSelected = self.userProfile
        
        followModel.getFollowers(completionHandler: { success, _ in
            if success {
                print("success")
                completionHandler(true,nil)
            }
        })
    }
    
    func configureButtonFollow(){
        let uid = Auth.auth().currentUser?.uid
        followModel.userSelected = self.userProfile
        followModel.getFollowersToButton(completionHandler: { success, _ in
            if success {

                if self.followModel.userFollowers == uid {

                    self.isFollowing = true
                }else{

                    self.isFollowing = false
                }
                self.getData()
            }
        })
    }
    func setupCollection(){
        profileCollectionView.delegate = viewModel
        profileCollectionView.dataSource = viewModel
        profileCollectionView.reloadData()
    }
    
    func passDataThrough(){
        self.viewModel = UserCollectionDelegateDataSource(userModel: userModel, view: self, followModel: followModel)
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

