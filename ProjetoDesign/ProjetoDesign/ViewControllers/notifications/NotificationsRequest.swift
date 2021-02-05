//
//  NotificationsRequest.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-05.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
class NotificationsRequest {
    let ref: DatabaseReference = Database.database().reference()
    var notificationsArray = [NotificationsModel]()
    var notificationsUser = [Usuario]()
    var userRequest = ViewRequest()
    var userID: String?
    func downloadData(completionHandler: @escaping (_ result: Bool,_ error: Error?) -> Void) {
        
        self.notificationsUser.removeAll()
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("users").child(uid).child("notifications").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
                
                if let notifications = snapshot.value as? [String: AnyObject] {
                    for(_, value) in notifications {
                        let userToshow = NotificationsModel()
                        
                        let whoIsFollowing = value["whoIsFollower"] as? String

                        userToshow.whoIsFollowing = whoIsFollowing

                        self.userRequest.downloadData(ID: userToshow.whoIsFollowing, completionHandler: {
                            success,_ in
                            
                            if success{
                                
                                self.notificationsUser = self.userRequest.notificationsUser

                                completionHandler(true,nil)
                                
                            }
                        })
                    }
                    
                }
               
            })
            
        }
    }
}
