//
//  CommentsService.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 05/01/21.
//

import struct Foundation.Date

struct Comment {
    let hasLike: Bool
    let text: String
    let user: UserComment
    let timeStamp: Date
    let numberOfLikes: Int
}

struct UserComment {
    let id: String
    let name: String
    let photo: String
}

protocol CommentsService {
    func get(postId: String, then handler: @escaping (Result<[Comment], Error>) -> ())
    func add(text: String, then handler: @escaping (Result<Void, Error>) -> ())
    func like(commentId: String, then handler: @escaping (Result<Void, Error>) -> ())
    func dislike(commentId: String, then handler: @escaping (Result<Void, Error>) -> ())
}
