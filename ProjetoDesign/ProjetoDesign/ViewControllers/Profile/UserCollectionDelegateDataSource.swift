//
//  UserTableDelegateDataSource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-05.
//

import Foundation
import UIKit
import FirebaseAuth
class UserCollectionDelegateDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let uid = Auth.auth().currentUser?.uid
    var userModel = userSelectedrequest()
    var view = UserViewController()
    var userSelected = [Usuario]()
    var followModel = FollowRequest()
   // var isFollowing: Bool?
    
    init(userModel: userSelectedrequest, view: UserViewController, followModel: FollowRequest) {
        self.userModel = userModel
        self.view = view
        self.followModel = followModel
    }
    func useArrayTo(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        userSelected.append(userModel.selectedUser!)
        completionHandler(true,nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return view.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionCell
        print(view.images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileReuCell", for: indexPath) as! ProfileCollectionReusableView
        cell.setup(user: userSelected[indexPath.row])
        
        if view.isFollowing == false{
            cell.followButton.setTitle("Follow", for: .normal)
            cell.followButton.layer.cornerRadius = 10
            cell.followButton.backgroundColor = .clear
            cell.followButton.layer.borderWidth = 1
            cell.followButton.setTitleColor(.black, for: .normal)
        }else if view.isFollowing == true{
            cell.followButton.setTitle("unfollow", for: .normal)
            cell.followButton.layer.cornerRadius = 10
            cell.followButton.setTitleColor(.white, for: .normal)
            cell.followButton.backgroundColor = UIColor(patternImage: (UIImage(named: "2.jpg")!))
        }
       
        cell.nameTap = {
            
            self.view.getFollowers(completionHandler: { success, _ in
                if success {
                    if self.followModel.stillFollower == self.uid {
                        cell.followButton.setTitle("unfollow", for: .normal)
                        cell.followButton.setTitleColor(.white, for: .normal)
                        cell.followButton.backgroundColor = UIColor(patternImage: (UIImage(named: "2.jpg")!))
                    }else{
                        cell.followButton.setTitle("Follow", for: .normal)
                        cell.followButton.layer.cornerRadius = 10
                        cell.followButton.backgroundColor = .clear
                        cell.followButton.layer.borderWidth = 1
                        cell.followButton.setTitleColor(.black, for: .normal)
                    }
                }
            })
        }
        return cell
    }
    
    
}