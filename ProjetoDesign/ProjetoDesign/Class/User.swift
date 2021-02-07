//
//  User.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import struct Foundation.Date

struct User: Decodable, Equatable {
    let id: String
    let name: String
    let imageProfileUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "UserID"
        case name = "Name"
        case imageProfileUrl = "profileUrl"
    }
}

struct PostUser: Equatable {
    let id: String?
    let timestamp: Date?
    let city: String?
    let temperature: String?
    let weatherType: String?
    let imagePostUrl: String
    let comments: String?
    let numberOfComments: Int
    let numberOfLikes: Int
    let isLiked: Bool
    let user: User

    // MARK: - Constructors

    init(id: String? = nil, userId: String = "", timestamp: Date? = nil, userName: String = "",
         userProfileUrl: String = "", city: String? = nil, temperature: String? = nil, weatherType: String? = nil,
         imagePostUrl: String = "", comments: String? = nil, numberOfComments: Int = 0, numberOfLikes: Int = 0,
         isLiked: Bool = false) {
        self.id = id
        self.city = city
        self.timestamp = timestamp
        self.temperature = temperature
        self.weatherType = weatherType
        self.imagePostUrl = imagePostUrl
        self.comments = comments
        self.numberOfComments = numberOfComments
        self.numberOfLikes = numberOfLikes
        self.isLiked = isLiked
        self.user = User(id: userId, name: userName, imageProfileUrl: userProfileUrl)
    }

    init(source: PostUser, user: User) {
        self.id = source.id
        self.city = source.city
        self.timestamp = source.timestamp
        self.temperature = source.temperature
        self.weatherType = source.weatherType
        self.imagePostUrl = source.imagePostUrl
        self.comments = source.comments
        self.numberOfComments = source.numberOfComments
        self.numberOfLikes = source.numberOfLikes
        self.isLiked = source.isLiked
        self.user = user
    }
}
