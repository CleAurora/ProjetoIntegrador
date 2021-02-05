//
//  ProfileViewModel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-04.
//

import Foundation
import UIKit
class ProfileViewModel: NSObject, UICollectionViewDelegate, UICollectionViewDataSource{
    var userData: Usuario?
    var userModel = ViewRequest()
    var view = ProfileViewController()
    var postRequest = DownloadImages()
    var nameUser: String?
    var imageUser: String?
    init(userModel: ViewRequest, view: ProfileViewController, posts: DownloadImages) {
        self.userModel = userModel
        self.view = view
        self.postRequest = posts
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postRequest.currentUserPost.count
    }
    func goNextView(){
        if let vc = UIStoryboard(name: "Setting", bundle: nil).instantiateInitialViewController() as? SettingViewController{
            vc.userData = userData
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ProfileCollectionCell

        if let vc = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateInitialViewController() as? PhotoDetailViewController {
            vc.name = nameUser
            vc.image = imageUser
            vc.postDetail = postRequest.currentUserPost[indexPath.row]
            vc.selectedFromCurrent = "Current User"
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionCell
        cell.setup(post: postRequest.currentUserPost[indexPath.row])

        return cell
    }
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileReuCell", for: indexPath) as! ProfileCollectionReusableView

        cell.setup(user: userModel.currentUser[indexPath.row])
        cell.postCountLabel.text = "\(postRequest.currentUserPost.count)"
        
        userData = userModel.currentUser[indexPath.row]
        nameUser = cell.nameLabel.text
        imageUser = cell.urlImage

        return cell

}
}
