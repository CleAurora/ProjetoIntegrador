//
//  Post.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import Foundation
class Post{
    var name: String
    var city: String
    var imageProfile: String
    var imagePost: String
    
    init(name: String, city: String, imageProfile: String, imagePost: String) {
        self.name = name
        self.city = city
        self.imageProfile = imageProfile
        self.imagePost = imagePost
    }
}
