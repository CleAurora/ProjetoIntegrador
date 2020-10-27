//
//  PhotoDetail.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import Foundation
class PhotoDetail{
    var name: String
    var city: String
    var imageProfile: String
    var imagePost: String
    var allImages: [String]
    var comments: String
    init(name: String, city: String, imageProfile: String, imagePost: String, comments: String, allImages: [String]) {
        self.name = name
        self.city = city
        self.imageProfile = imageProfile
        self.imagePost = imagePost
        self.comments = comments
        self.allImages = allImages
    }
}
