//
//  User.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

class User {
    // MARK: - Properties

    var name: String
    var imageProfile: String

    // MARK: - Constructors

    init(name: String, imageProfile: String) {
        self.name = name
        self.imageProfile = imageProfile
    }
}

final class PostUser: User {
    // MARK: - Proprierts

    var city: String?
    var temperature: Double?
    var imagePost: String
    var allImages: [String]
    var comments: String

    // MARK: - Constructors

    init(name: String, city: String? = nil, temperature: Double? = nil, imageProfile: String, imagePost: String, comments: String, allImages: [String]) {
        self.city = city
        self.temperature = temperature
        self.imagePost = imagePost
        self.comments = comments
        self.allImages = allImages

        super.init(name: name, imageProfile: imageProfile)
    }
}
