//
//  Comments.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import struct Foundation.Date
import struct Foundation.URL

struct UserViewModel {
    let name: String?
    let photoUrl: URL?
}

struct CommentViewModel {
    let user: UserViewModel
    let text: String
    let timeStamp: Date
    let numberOfLikes: Int

    init(userName: String?, text: String, image: String, timeStamp: Date = Date(), numberOfLikes: Int = 0) {
        self.user = UserViewModel(name: userName, photoUrl: URL(string: image))
        self.text = text
        self.timeStamp = timeStamp
        self.numberOfLikes = numberOfLikes
    }
}
