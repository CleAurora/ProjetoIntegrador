//
//  Comments.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//
import struct Foundation.Date

struct CommentViewModel {
    let userName: String
    let text: String
    let userImageUrl: String
    let timeStamp: Date
    let numberOfLikes: Int

    init(userName: String, text: String, image: String, timeStamp: Date = Date(), numberOfLikes: Int = 0) {
        self.userName = userName
        self.userImageUrl = image
        self.text = text
        self.timeStamp = timeStamp
        self.numberOfLikes = numberOfLikes
    }
}
