//
//  DownloadImages.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-07.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
class DownloadImages {
    var allPost = [DownloadPost]()
    var currentUserPost = [DownloadPost]()
    var selectedPost = [DownloadPost]()
    var selectedUser: Usuario?
    let uid = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!

    func loadData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        do{
            self.allPost.removeAll()
            self.currentUserPost.removeAll()
            self.selectedPost.removeAll()
            self.ref = Database.database().reference()
            let reference = ref.child("posts")
            reference.observe(.value, with: {(snapshot) in
                if let posts = snapshot.value as? [String: AnyObject] {
                    for(_, value) in posts {
                       let userToshow = DownloadPost()

                        let imagePost = value["ImageUrl"] as? String
                        let caption = value["Caption"] as? String
                        let city = value["City"] as? String
                        let userID = value["UserId"] as? String
                        let weather = value["Weather"] as? String
                        let weatherType = value["WeatherType"] as? String

                        userToshow.imagePost = imagePost
                        userToshow.caption = caption
                        userToshow.city = city
                        userToshow.userID = userID
                        userToshow.weather = weather
                        userToshow.weatherype = weatherType

                        self.allPost.append(userToshow)
                        if let user = self.uid {
                            if user == userToshow.userID {
                                self.currentUserPost.append(userToshow)
                            }
                            }
                        let userSelectedID = self.selectedUser?.userID

                        if userSelectedID == userToshow.userID{
                        self.selectedPost.append(userToshow)
                        }
                    }
                    completionHandler(true,nil)
                }
            })
        }catch{
            completionHandler(false,nil)
        }
    }
}
