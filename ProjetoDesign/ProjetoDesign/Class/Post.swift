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
    var comments: String
    init(name: String, city: String, imageProfile: String, imagePost: String, comments: String) {
        self.name = name
        self.city = city
        self.imageProfile = imageProfile
        self.imagePost = imagePost
        self.comments = comments
    }
}
