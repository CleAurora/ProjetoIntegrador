//
//  followRequest.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-05.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FollowRequest {
    var userSelected: Usuario?
    var stillFollower: String!
    var userFollowers: String!
    var idFollowers: String!
    var userFollowing: String!
    var idFollowing: String!
    var followingActive = false
    var followingArray: [String] = []
    var followingCount = 0
    var followersCount = 0
    var follower = [readFollow]()
    let uid = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    var userRequest = ViewRequest()
    func setFollowers(){
        if let userID = userSelected?.userID {

            self.ref = Database.database().reference()
            var reference = self.ref
            var notific = self.ref
            
                if userFollowers != uid {
                    let reference = ref.child("users").child(userID).child("followers").child(self.uid!)

                    let dict = ["whoIsFollower": uid] as [String: Any]
                    reference.updateChildValues(dict)
                    self.stillFollower = userFollowers
                    
                    notific = ref.child("users").child(userID).child("notifications").child(self.uid!)
                    notific?.updateChildValues(dict)
                    
                    let followers = ref.child("users").child(userID)
                    let followersDict = ["followersCount": self.followersCount + 1] as [String: Any]
                    followers.updateChildValues(followersDict)
                    
                }else if userFollowers == uid {
                   reference?.child("users").child(userID).child("followers").child(self.uid!).removeValue()
                    let followers = ref.child("users").child(userID)
                    
                    let followersDict = ["followersCount": self.followersCount - 1] as [String: Any]
                    followers.updateChildValues(followersDict)
                    self.stillFollower = userFollowers
                }
            self.userFollowers = nil
        }
    }

    func setFollowing(){
        if let userID = userSelected?.userID {
            if let uid = self.uid {

                self.ref = Database.database().reference()
                var reference = self.ref
               
                
                    if userFollowing != userID {
                        reference = ref.child("users").child(uid).child("following").child(userID)

                        let dict = ["whoIsFollowing": userID] as [String: Any]
                        reference?.updateChildValues(dict)
                        
                        let following = ref.child("users").child(uid)
                        let followingDict = ["followingCount": self.followingCount + 1] as [String: Any]
                        following.updateChildValues(followingDict)
                        
                    }else if userFollowing == userID {
                      reference?.child("users").child(uid).child("following").child(userID).removeValue()
                        
                        let following = ref.child("users").child(uid)
                        let followingDict = ["followingCount": self.followingCount - 1] as [String: Any]
                        following.updateChildValues(followingDict)
                    }
                self.userFollowing = nil
            }
        }
    }

    func getFollowers(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        self.followersCount = 0
        
        if let userID = userSelected?.userID {
            self.ref = Database.database().reference()
            self.ref.child("users").child(userID).child("followers").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
                    if let users = snapshot.value as? [String: AnyObject] {
                       
                        for (_, value) in users{
                            if let whoFollower = value["whoIsFollower"] as? String {

                                let uid = self.uid

                                if uid == whoFollower {
                                    let userToshow = readFollow()
                                    userToshow.followID = whoFollower
                                    self.follower.append(userToshow)
                                    self.userFollowers = whoFollower
                                }
                                self.followersCount = self.followersCount + 1

                            }
                        }

                    }
                })

             self.getFollowing()
             completionHandler(true,nil)
        }
    }

    func getFollowing(){
        self.followingCount = 0
        if let userID = userSelected?.userID {
            self.ref = Database.database().reference()
            ref.child("users")
                .child(uid!)
                .child("following")
                .queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in

                    if let users = snapshot.value as? [String: AnyObject] {
                        for (_, value) in users{
                            if let whoFollowing = value["whoIsFollowing"] as? String {
                                let uid = self.userSelected?.userID
                                if uid == whoFollowing {
                                    let userToshow = readFollow()

                                    userToshow.followID = whoFollowing
                                    self.follower.append(userToshow)
                                    self.userFollowing = whoFollowing
                                   
                                }
                                self.followingCount = self.followingCount + 1
                            }
                        }
                        self.setFollowing()
                        self.setFollowers()
                    }
            })

        }
    }
    func getFollowersToButton(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if let userID = userSelected?.userID {
            self.ref = Database.database().reference()
            self.ref.child("users").child(userID).child("followers").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
                    if let users = snapshot.value as? [String: AnyObject] {

                        for (_, value) in users{
                            if let whoFollower = value["whoIsFollower"] as? String {

                                let uid = self.uid

                                if uid == whoFollower {
                                    let userToshow = readFollow()

                                    userToshow.followID = whoFollower
                                    self.follower.append(userToshow)
                                    self.userFollowers = whoFollower
                                }

                            }
                        }

                    }
                completionHandler(true,nil)
                })
        }
    }
    func getFollowingToButton(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        self.followingCount = 0
        self.followingArray.removeAll()
        if let userID = userSelected?.userID {
            self.ref = Database.database().reference()
            ref.child("users")
                .child(uid!)
                .child("following")
                .queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in

                    if let users = snapshot.value as? [String: AnyObject] {
                        
                        for (_, value) in users{
                            if let whoFollowing = value["whoIsFollowing"] as? String {
                                let uid = self.userSelected?.userID
                                if userID == whoFollowing {
                                    let userToshow = readFollow()
                                    userToshow.followID = whoFollowing
                                    self.follower.append(userToshow)
                                    self.followingArray.append(userToshow.followID)
                                    self.followingActive = true
                                    completionHandler(true,nil)
                                }else{
                                    self.followingActive = false
                                    completionHandler(true,nil)
                                }
                         }else{
                            self.followingActive = false
                            completionHandler(true,nil)
                        }
                    }
                }
            })
        }
    }
}
