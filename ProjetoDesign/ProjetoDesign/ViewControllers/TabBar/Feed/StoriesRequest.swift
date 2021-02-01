//
//  StoriesRequest.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-21.
//

import Foundation
import Firebase

class StoriesRequest {
    var ref: DatabaseReference!
    var whoHasStories = [StoriesModel]()
    var storiesArray = [StoriesModel]()
    var currentUserStories = [StoriesModel]()
    let uid = Auth.auth().currentUser?.uid
    var followingArray = [String]()
    var userHasActiveStories = [String]()
    var userRequest = ViewRequest()
    var storiesUser = [Usuario]()
    var alreadyHasArray = [String]()
    
   func getStories(whoIsFollowing: String, completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){

        self.ref = Database.database().reference()
        
        let reference = ref.child("stories")
        reference.observe(.value) { (snapshot) in
        
        if let stories = snapshot.value as? [String: AnyObject] {
            for (_, value) in stories {
               
                let storiesToshow = StoriesModel()
                
                let image = value["StorieImage"] as? String
                let userID = value["userID"] as? String
                let timeStamp = value["TimeStamp"] as? Double
                let duration = value["Duration"] as? Int
                let childID = value["childID"] as? String
                
                storiesToshow.image = image
                storiesToshow.timeStamp = timeStamp
                storiesToshow.userID = userID
                storiesToshow.duration = duration
                storiesToshow.childID = childID
                
                if whoIsFollowing == storiesToshow.userID {

                    self.loadData(StoriesUser: whoIsFollowing, completionHandler: { success, _ in
                        if success {
                           completionHandler(true,nil)
                        }
                    })
                }
                if storiesToshow.userID == self.uid {
                    self.currentUserStories.append(storiesToshow)

             }
          }
        }
    }
  }
    func checkFollowing(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        
        self.ref = Database.database().reference()
        if let userID = uid {
            let reference = ref.child("users").child(userID).child("following")
            reference.queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
                
                if let users = snapshot.value as? [String: AnyObject] {
                    for (_, value) in users{
                        if let whoFollowing = value["whoIsFollowing"] as? String {
                            
                                let userToshow = readFollow()
                                userToshow.followID = whoFollowing
                                self.getStories(whoIsFollowing: userToshow.followID, completionHandler: { success, _ in
                                    if success {
                                       completionHandler(true, nil)
                                    }
                            })
                        }else{
                            completionHandler(true,nil)
                        }
                    }
                }
          })
        }
    }
    
    func loadData(StoriesUser: String ,completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        
        self.ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid {
            let reference = self.ref.child("users")
            reference.observeSingleEvent(of: .value) { (snapshot) in
                   
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
                        
                        
                            userToshow.name = user
                            userToshow.nickname = nickname
                            userToshow.email = email
                            userToshow.userID = userID
                            userToshow.profileUrl = profileUrl
                            userToshow.bio = bio
                            userToshow.followers = followers
                            userToshow.following = following
                            
                            
                            if self.alreadyHasArray.contains(StoriesUser){
                                //if already contains user in array do nothing
                            }else{
                                
                                if userToshow.userID == StoriesUser {
                                    self.storiesUser.append(userToshow)
                                    self.alreadyHasArray.append(userToshow.userID)
                                    completionHandler(true,nil)
                                }
                        }
                    }
                }
            }
        }
    }
}



