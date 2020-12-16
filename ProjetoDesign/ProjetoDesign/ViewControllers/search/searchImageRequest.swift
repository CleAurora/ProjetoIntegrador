//
//  searchImageRequest.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-16.
//

import Foundation
import Firebase
import Alamofire

class searchImageRequest {
    
    var ref: DatabaseReference!
    var userArray = [searchModel]()
    func loadData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        self.ref = Database.database().reference()
        self.userArray.removeAll()
        let reference = self.ref.child("posts")
        reference.observe(.value, with: {(snapshot) in
            
            if let users = snapshot.value as? [String: AnyObject] {
                for(_, value) in users {
                    
                   let userToshow = searchModel()
                    
                    var city = value["City"] as? String
                    var caption = value["Caption"] as? String
                    var imageURL = value["ImageUrl"] as? String
                    var userid = value["UserId"] as? String
                    var weather = value["Weather"] as? String
                    var weathertype = value["WeatherType"] as? String
                    
                    userToshow.city = city
                    userToshow.weather = weather
                    userToshow.weatherType = weathertype
                    userToshow.imagePostUrl = imageURL
                    userToshow.userId = userid
                    userToshow.caption = caption
                    
                    self.userArray.append(userToshow)
                    
            }
        }
            completionHandler(true,nil)
      })
    }
}
