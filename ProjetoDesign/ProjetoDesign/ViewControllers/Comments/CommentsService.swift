//
//  CommentsService.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 05/01/21.
//

import struct Foundation.Date

struct PostComment {
    let comments: [Comment]
    let user: UserComment
}

struct Comment {
    let text: String
    let user: UserComment
    let timeStamp: Date
    let numberOfLikes: Int
}

struct UserComment: Equatable, Hashable {
    let id: String
    let name: String?
    let photo: String?
}

protocol CommentsService {
    func get(postId: String, then handler: @escaping (Result<PostComment, Error>) -> ())
    func add(text: String, forPost postId: String, then handler: @escaping (Result<Void, Error>) -> ())
}
