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
    
    var ref: DatabaseReference!
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
        self.userArray.removeAll()
        self.storiesUser.removeAll()
        self.notificationsUser.removeAll()
        
        self.ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid {
            let reference = self.ref.child("users")
                reference.observe(.value) { (snapshot) in

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
                                self.userArray.append(userToshow)

                            }else{
                                self.currentUser.append(userToshow)
                            }
                    
                            if self.whoIsFollowing == userToshow.userID {
                                self.notificationsUser.append(userToshow)
                            }
                            
                            if self.userSelected == userToshow.userID {
                                self.userName = userToshow.name
                                self.imageProfile = userToshow.profileUrl
                            }
                                self.allUserArray.append(userToshow)
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
        self.userArray.removeAll()
        self.notificationsUser.removeAll()
       
        self.ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid {
            let reference = self.ref.child("users")
                reference.observe(.value) { (snapshot) in

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
                                self.userArray.append(userToshow)

                            }else{
                                self.currentUser.append(userToshow)
                            }
                            if ID == userToshow.userID {
                                if self.containtUser.contains(userToshow.userID) {
                                //do nothing
                                }else {
                                    self.notificationsUser.append(userToshow)
                                    self.containtUser.append(userToshow.userID)
                                }
                                
                                
                            }
                            if self.userSelected == userToshow.userID {
                                self.userName = userToshow.name
                                self.imageProfile = userToshow.profileUrl
                            }
                                self.allUserArray.append(userToshow)
                    }
                }
                    completionHandler(true,nil)
            }

        }
    }

}
