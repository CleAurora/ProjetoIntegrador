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
}

class StoriesDownload {
    var ref: DatabaseReference!
    var uid = Auth.auth().currentUser?.uid
    var storiesData = [StoriesModel]()
    
    func downloadStories(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        
        self.ref = Database.database().reference()
        
        let reference = ref.child("stories").child(uid!)
        reference.queryOrdered(byChild: "TimeStamp").observeSingleEvent(of: .value, with: {snapshot in
            //queryOrderedByKey
            if let stories = snapshot.value as? [String: AnyObject] {
  
                for(_, value) in stories {
                    let storiesToShow = StoriesModel()
                    
                    let image = value["storyImage"] as? String
                    let userID = value["userID"] as? String
                    let timeStamp = value["TimeStamp"] as? Double
                    
                    storiesToShow.image = image
                    storiesToShow.timeStamp = timeStamp
                    storiesToShow.userID = userID
                    
                   
                    self.storiesData.append(storiesToShow)
                    print(storiesToShow.image)
                    print(self.storiesData.count)
                }
            }
            completionHandler(true,nil)
        })
    }
}
