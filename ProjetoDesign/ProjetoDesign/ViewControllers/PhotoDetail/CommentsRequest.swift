//
//  CommentsRequest.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-02-04.
//

import Foundation
import Firebase

class CommentsModel {
    var Text: String!
    var TimeStamp: Double!
    var userID: String!
}

class CommentsDetailModel: NSObject{
    var text: String?
    var timeStamp: Double?
    var userID: String?
    var profileImage: String?
    var nameUser: String?
    
    init(nameUser: String, profileImage: String, userID: String, timeStamp: Double, text: String){
        self.nameUser = nameUser
        self.profileImage = profileImage
        self.userID = userID
        self.timeStamp = timeStamp
        self.text = text
    }
}
class CommentsRequest{
    var ref: DatabaseReference!
    var uid = Auth.auth().currentUser?.uid
    var comments = [CommentsModel]()
    var user = [Usuario]()
    var commentsDetails = [CommentsDetailModel]()
    
    func getComments(ID: String! ,completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        
        if let childKey = ID {
            self.ref = Database.database().reference()
            let reference = self.ref.child("posts").child(childKey).child("Comments")
            reference.queryOrderedByKey().observe(.value, with: {(snapshot) in
                for commentsSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                    if let value = commentsSnapshot.value as? [String: AnyObject] {
                        let commentsToshow = CommentsModel()
                        let text = value["Text"] as? String
                        let timeStamp = value["TimeStamp"] as? Double
                        let userID = value["UserID"] as? String
                       
                           commentsToshow.Text = text
                           commentsToshow.TimeStamp = timeStamp
                           commentsToshow.userID = userID
                       
                        self.comments.append(commentsToshow)
                        self.downloadData(ID: commentsToshow.userID, commentsText: commentsToshow.Text, timeStampMessage: commentsToshow.TimeStamp, completionHandler: { success, _ in
                            if success {
                             //   print(self.commentsDetails.count)
                                completionHandler(true,nil)
                            }
                        })
                    }
                }
               
            })
           
        }
    }
    func downloadData(ID: String?, commentsText: String?, timeStampMessage: Double?, completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        self.commentsDetails.removeAll()
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
                            if let userID = ID, let timeStamp = timeStampMessage, let message = commentsText {
                               
                            if userID == userToshow.userID {
                                self.commentsDetails.append(
                                    CommentsDetailModel(nameUser: userToshow.name,
                                                        profileImage: userToshow.profileUrl,
                                                        userID: userToshow.userID,
                                                        timeStamp: timeStamp,
                                                        text: message ))
                                completionHandler(true,nil)
                            }
                        }
                    }
                }
            }
        }
    }
}
