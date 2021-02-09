//
//  ViewRequest.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-04.
//

import Foundation
import Firebase
import FirebaseAuth

class ViewRequest{
    
    private lazy var databaseReference: DatabaseReference = Database.database().reference()
    var userArray = [Usuario]()
    var allUserArray = [Usuario]()
    var currentUser = [Usuario]()
    var notificationsUser = [Usuario]()
    var storiesUser = [Usuario]()
    var whoIsFollowing: String?
    var userSelected: String?
    var userName: String?
    var imageProfile: String?
    var userHasActiveStories = [String]()
    var containtUser = [String]()
    
    func loadData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        userArray.removeAll()
        storiesUser.removeAll()
        notificationsUser.removeAll()
        
        if let uid = Auth.auth().currentUser?.uid {
            databaseReference.child("users").observe(.value) { [unowned self] (snapshot) in

                if let users = snapshot.value as? [String: AnyObject] {
                    for(_, value) in users {

                        let userToshow = Usuario()

                        let user = value["Name"] as? String
                        let nickname = value["Nickname"] as? String
                        let email = value["Email"] as? String
                        let userID = value["UserID"] as? String
                        let profileUrl = value["profileUrl"] as? String
                        let bio = value["Bio"] as? String
                        let followers = value ["followersCount"] as? Int
                        let following = value["followingCount"] as? Int
                        let website = value["Website"] as? String

                        userToshow.name = user
                        userToshow.nickname = nickname
                        userToshow.email = email
                        userToshow.userID = userID
                        userToshow.profileUrl = profileUrl
                        userToshow.bio = bio
                        userToshow.followers = followers
                        userToshow.following = following
                        userToshow.website = website

                        if uid != userToshow.userID {
                            userArray.append(userToshow)

                        }else{
                            currentUser.append(userToshow)
                        }

                        if whoIsFollowing == userToshow.userID {
                            print(notificationsUser.count)
                            notificationsUser.append(userToshow)
                        }

                        if userSelected == userToshow.userID {
                            userName = userToshow.name
                            imageProfile = userToshow.profileUrl
                        }
                        allUserArray.append(userToshow)
                    }
                }
                completionHandler(true,nil)
            }

        }
    }

    func getNumberOfRow() -> Int{
        return userArray.count
    }
    
    func downloadData(ID: String,completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        userArray.removeAll()
        notificationsUser.removeAll()
        containtUser.removeAll()
        if let uid = Auth.auth().currentUser?.uid {
            databaseReference.child("users").observe(.value) { [unowned self] (snapshot) in
                if let users = snapshot.value as? [String: AnyObject] {
                    for(_, value) in users {

                        let userToshow = Usuario()

                        let user = value["Name"] as? String
                        let nickname = value["Nickname"] as? String
                        let email = value["Email"] as? String
                        let userID = value["UserID"] as? String
                        let profileUrl = value["profileUrl"] as? String
                        let bio = value["Bio"] as? String
                        let followers = value ["Followers"] as? Int
                        let following = value["Following"] as? Int
                        let website = value["Website"] as? String

                        userToshow.name = user
                        userToshow.nickname = nickname
                        userToshow.email = email
                        userToshow.userID = userID
                        userToshow.profileUrl = profileUrl
                        userToshow.bio = bio
                        userToshow.followers = followers
                        userToshow.following = following
                        userToshow.website = website

                        if uid != userToshow.userID {
                            userArray.append(userToshow)

                        }else{
                            currentUser.append(userToshow)
                        }
                        if ID == userToshow.userID {
                            if containtUser.contains(userToshow.userID) {
                                
                                //do nothing
                            }else {
                                
                                notificationsUser.append(userToshow)
                                containtUser.append(userToshow.userID)
                            }


                        }
                        if userSelected == userToshow.userID {
                            userName = userToshow.name
                            imageProfile = userToshow.profileUrl
                        }
                        allUserArray.append(userToshow)
                    }
                }
                completionHandler(true,nil)
            }

        }
    }

}
