//
//  User.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

struct User: Decodable {
    let id: String
    let name: String
    let imageProfileUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "UserID"
        case name = "Name"
        case imageProfileUrl = "profileUrl"
    }
}

struct PostUser {
    // MARK: - Proprierts

    let city: String?
    let temperature: String?
    let weatherType: String?
    let imagePostUrl: String
    let allImages: [String]
    let comments: String?
    let user: User

    // MARK: - Constructors

    init(userId: String = "", userName: String = "", userProfileUrl: String = "", city: String? = nil,
         temperature: String? = nil, weatherType: String?, imagePostUrl: String = "", allImages: [String] = [],
         comments: String? = nil) {
        self.city = city
        self.temperature = temperature
        self.weatherType = weatherType
        self.imagePostUrl = imagePostUrl
        self.allImages = allImages
        self.comments = comments
        self.user = User(id: userId, name: userName, imageProfileUrl: userProfileUrl)
    }

    init(source: PostUser, user: User) {
        self.city = source.city
        self.temperature = source.temperature
        self.weatherType = source.weatherType
        self.imagePostUrl = source.imagePostUrl
        self.allImages = source.allImages
        self.comments = source.comments
        self.user = user
    }
}
