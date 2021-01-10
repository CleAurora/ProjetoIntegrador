//
//  CommentsViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 05/01/21.
//

import struct Foundation.URL

final class CommentsViewModel {
    private let postId: String?
    private let service: CommentsService

    private(set) var user: UserViewModel? = nil
    private(set) var comments: [CommentViewModel] = []
    private(set) var failure: Error? = nil

    init(postId: String?, service: CommentsService = FirebaseRealtimeDatabaseCommentsService.shared) {
        assert(postId != nil)

        self.postId = postId
        self.service = service
    }

    func get(then handler: @escaping () -> Void) {
        failure = nil

        if let id = postId {
            service.get(postId: id) { [self] result in
                do {
                    let model = try result.get()
                    let userPhoto = model.user.photo ?? ""

                    user = UserViewModel(name: model.user.name, photoUrl: URL(string: userPhoto))
                    comments = model.comments.map { comment -> CommentViewModel in
                        CommentViewModel(
                            userName: comment.user.name,
                            text: comment.text,
                            image: comment.user.photo ?? "",
                            timeStamp: comment.timeStamp,
                            numberOfLikes: comment.numberOfLikes
                        )
                    }
                } catch {
                    failure = error
                }

                handler()
            }
        }
    }

    func add(comment: String?, then handler: @escaping () -> Void) {
        failure = nil

        if let id = postId, let comment = comment, !comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            service.add(text: comment, forPost: id) { [self] result in
                do {
                    _ = try result.get()
                } catch {
                    failure = error
                }

                handler()
            }
        }
    }
}
