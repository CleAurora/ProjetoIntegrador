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
    var postRequest = DownloadImages()
    var isFollowing: Bool?

    init(userModel: userSelectedrequest, view: UserViewController, followModel: FollowRequest, postRequest: DownloadImages) {
        self.userModel = userModel
        self.view = view
        self.followModel = followModel
        self.postRequest = postRequest
    }

    func useArrayTo(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        userSelected.append(userModel.selectedUser!)
        completionHandler(true,nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postRequest.selectedPost.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionCell
        cell.setup(post: postRequest.selectedPost[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileReuCell", for: indexPath) as! ProfileCollectionReusableView
        cell.setup(user: userSelected[indexPath.row])
        cell.postCountLabel.text = "\(postRequest.selectedPost.count)"
        
        self.followModel.getFollowingToButton(completionHandler: { success, _ in
            if success {
                if self.followModel.followingArray.contains(self.userSelected[indexPath.row].userID){
                    cell.followButton.setTitle("unfollow", for: .normal)
                    cell.followButton.layer.cornerRadius = 10
                    cell.followButton.setTitleColor(.white, for: .normal)
                    cell.followButton.backgroundColor = UIColor(patternImage: (UIImage(named: "2.jpg")!))
                    
                }else{
                    cell.followButton.setTitle("Follow", for: .normal)
                    cell.followButton.layer.cornerRadius = 10
                    cell.followButton.backgroundColor = .clear
                    cell.followButton.setTitleColor(.black, for: .normal)
                    cell.followButton.layer.borderWidth = 1
                }
            }
        })
        
        cell.nameTap = {
            self.view.getFollowers(completionHandler: { success, _ in

                if success {
                    let buttonLabel = cell.followButton.titleLabel?.text
                    if buttonLabel == "Follow"{
                        cell.followButton.setTitle("unfollow", for: .normal)
                        cell.followButton.setTitleColor(.white, for: .normal)
                        cell.followButton.backgroundColor = UIColor(patternImage: (UIImage(named: "2.jpg")!))

                    }else if buttonLabel == "unfollow"{
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
