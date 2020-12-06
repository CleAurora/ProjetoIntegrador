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
    
    var userFollowers: String!
    var idFollowers: String!
    var userFollowing: String!
    var idFollowing: String!
    
    var follower = [readFollow]()
    let uid = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    
    func setFollowers(){
        if let userID = userSelected?.userID {
            
            self.ref = Database.database().reference()
            var reference = self.ref            
                if userFollowers != uid {
                    let reference = ref.child("users").child(userID).child("followers").child(self.uid!)
                    
                    let dict = ["whoIsFollower": uid] as [String: Any]
                    reference.updateChildValues(dict)
                }else if userFollowers == uid {
                   reference?.child("users").child(userID).child("followers").child(self.uid!).removeValue()
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
                        
                    }else if userFollowing == userID {
                      reference?.child("users").child(uid).child("following").child(userID).removeValue()
                    }
                self.userFollowing = nil
            }
        }
    }
    
    func getFollowers(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if let userID = userSelected?.userID {
            self.ref = Database.database().reference()
            self.ref.child("users").child(userID).child("followers").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
                    if let users = snapshot.value as? [String: AnyObject] {

                        for (_, value) in users{
                            if let whoFollower = value["whoIsFollower"] as? String {
                                print(whoFollower)
                                print("tessssssste")
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
               
                })
             self.getFollowing()
             completionHandler(true,nil)
            
        }
    }
    
    func getFollowing(){
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
                            }
                        }
                        self.setFollowing()
                        self.setFollowers()
                    }
            })
            
            
        }
    }
}
