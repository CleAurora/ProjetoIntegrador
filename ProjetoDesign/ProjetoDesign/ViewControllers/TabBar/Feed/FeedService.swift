//
//  FeedService.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 07/12/20.
//

protocol FeedService {
    func load(then handler: @escaping (Result<[PostUser], Error>) -> Void)
    func getUser(then handler: @escaping (Result<Profile, Error>) -> Void)
    func like(postId: String, then handler: @escaping (Result<Void, Error>) -> Void)
    func dislike(postId: String, then handler: @escaping (Result<Void, Error>) -> Void)
}
