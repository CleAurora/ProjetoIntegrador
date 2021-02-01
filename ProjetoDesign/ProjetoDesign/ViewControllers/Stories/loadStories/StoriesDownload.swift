//
//  StoriesDownload.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-19.
//

import Foundation
import Firebase

class StoriesModel: NSObject {
    var userID: String!
    var timeStamp: Double!
    var image: String!
    var duration: Int!
    var childID: String!
    var nameUser: String?
    var imageProfile: String?
}

class StoriesDownload {
    var ref: DatabaseReference!
    var uid = Auth.auth().currentUser?.uid
    var storiesData = [StoriesModel]()
    
    func downloadStories(User: String!, UserName: String!, UserProfile: String!, completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        self.storiesData.removeAll()
        self.ref = Database.database().reference()
        
        let reference = ref.child("stories")
        reference.queryOrdered(byChild: "TimeStamp").observeSingleEvent(of: .value, with: {snapshot in
            for postSnapshot in snapshot.children.allObjects as! [DataSnapshot] {

                if let value = postSnapshot.value as? [String: AnyObject]{
                    
                    let storiesToShow = StoriesModel()
                    
                    let image = value["StorieImage"] as? String
                    let userID = value["userID"] as? String
                    let timeStamp = value["TimeStamp"] as? Double
                    let duration = value["Duration"] as? Int
                    let childID = value["childID"] as? String
                    
                    storiesToShow.image = image
                    storiesToShow.timeStamp = timeStamp
                    storiesToShow.userID = userID
                    storiesToShow.duration = duration
                    storiesToShow.childID = childID
                    storiesToShow.nameUser = UserName
                    storiesToShow.imageProfile = UserProfile
                    if storiesToShow.userID == User {
                        self.storiesData.append(storiesToShow)
                        completionHandler(true,nil)
                    }
                    
                }
            }
            
        })
    }
}
