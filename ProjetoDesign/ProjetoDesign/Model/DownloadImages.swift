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
            reference.queryOrderedByKey().observe(.value, with: {(snapshot) in
                for postSnapshot in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    if let value = postSnapshot.value as? [String: AnyObject]{
                      
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
                        userToshow.childKey = postSnapshot.key
                        
                        if let weather = weather, weather.isEmpty {
                            userToshow.weatherype = ""
                        } else if weather == nil {
                            userToshow.weatherype = ""
                        } else if let weatherType = weatherType, !weatherType.isEmpty {
                            switch weatherType.lowercased() {
                            case "thunderstorm", "drizzle", "rain":
                                userToshow.weatherype = "rain"

                            case "snow":
                                userToshow.weatherype = "snow"

                            case "clear":
                                userToshow.weatherype = "clear"

                            default:
                                userToshow.weatherype = "clouds"
                            }
                        }

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
