//
//  Post.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import Foundation
class Post{
    // MARK: - Proprierts 
    var name: String
    var city: String
    var imageProfile: String
    var imagePost: String
    var allImages: [String]
    var comments: String

    // MARK: - Constructors
    init(name: String, city: String, imageProfile: String, imagePost: String, comments: String, allImages: [String]) {
        self.name = name
        self.city = city
        self.imageProfile = imageProfile
        self.imagePost = imagePost
        self.comments = comments
        self.allImages = allImages
    }
}
