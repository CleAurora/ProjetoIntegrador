//
//  User.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import Foundation
class User{
    var name: String
    var imageProfile: String
    
    init(name: String, imageProfile: String) {
        self.name = name
        self.imageProfile = imageProfile
    }

}
class PostUser: User{
    var city: String
    var imagePost: String
    var allImages: [String]
    var comments: String
    init(name: String, city: String, imageProfile: String, imagePost: String, comments: String, allImages: [String]) {
        self.city = city
        self.imagePost = imagePost
        self.comments = comments
        self.allImages = allImages
        super.init(name: name, imageProfile: imageProfile)
    }
}
