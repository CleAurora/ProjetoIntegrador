//
//  User.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import Foundation
class User{
    // MARK: - Proprierts
    var name: String
    var imageProfile: String
    
    // MARK: - Constructors
    init(name: String, imageProfile: String) {
        self.name = name
        self.imageProfile = imageProfile
    }

}
class PostUser: User{
    // MARK: - Proprierts
    var city: String
    var imagePost: String
    var allImages: [String]
    var comments: String
    
    // MARK: - Constructors
    init(name: String, city: String, imageProfile: String, imagePost: String, comments: String, allImages: [String]) {
        self.city = city
        self.imagePost = imagePost
        self.comments = comments
        self.allImages = allImages
        super.init(name: name, imageProfile: imageProfile)
    }
}
