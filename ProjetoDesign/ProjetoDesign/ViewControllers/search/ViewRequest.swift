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
    func loadData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        self.userArray.removeAll()
        
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
                        
                            userToshow.name = user
                            userToshow.nickname = nickname
                            userToshow.email = email
                            userToshow.userID = userID
                            userToshow.profileUrl = profileUrl
                            userToshow.bio = bio
                            userToshow.followers = followers
                            userToshow.following = following
                            
                            if uid != userToshow.userID {
                                self.userArray.append(userToshow)
                                
                            }else{
                                print(userToshow.name)
                                self.currentUser.append(userToshow)
                            }
                                self.allUserArray.append(userToshow)
                            
                            
                            
                    }
                        
                }
                    completionHandler(true,nil)
                
            }
            
           
        }
    }
    
    func getNumberOfRow() -> Int{
        return userArray.count ?? 0
    }
    
}
