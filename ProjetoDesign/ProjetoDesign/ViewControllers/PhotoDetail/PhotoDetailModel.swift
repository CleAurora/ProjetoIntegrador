//
//  PhotoDetailModel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-17.
//

struct PhotoDetailModel {
    var name: String?
    var city: String?
    var imageProfile: String?
    var imagePost: String?
    var caption: String?
    var liked: String!
    var comments: String?
    var weather: String?

    init(name: String, city: String, imageProfile: String, imagePost: String, caption: String, comments: String, liked: String, weather: String) {
        self.name = name
        self.city = city
        self.imagePost = imagePost
        self.imageProfile = imageProfile
        self.caption = caption
        self.comments = comments
        self.liked = liked
        self.weather = weather
    }
}
