//
//  FirebaseRealtimeDatabaseCommentsService.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 05/01/21.
//

import Firebase
import FirebaseDatabase

final class FirebaseRealtimeDatabaseCommentsService: CommentsService {
    private let databaseReference: DatabaseReference

    enum ServiceError: Error {
        case userNotLogged
        case notFound
        case idNotGenerated
        case imageDataNotAvailable
        case urlNotGenerated
        case parse
    }

    static let shared: CommentsService = FirebaseRealtimeDatabaseCommentsService()

    private init() {
        databaseReference = Database.database().reference()
    }

    func get(postId: String, then handler: @escaping (Result<PostComment, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {
            return handler(.failure(ServiceError.userNotLogged))
        }

        get(userId: user.uid) { [self] result in
            do {
                let loggedUser = try result.get()

                get(postId: postId, user: loggedUser, then: handler)
            } catch {
                handler(.failure(error))
            }
        }
    }

    private func get(postId: String, user: UserComment, then handler: @escaping (Result<PostComment, Error>) -> ()) {
        databaseReference.child("posts").child(postId).observeSingleEvent(of: .value) { [self] snapshot in
            guard snapshot.exists(), let dictionary = snapshot.value as? [String: AnyObject] else {
                return handler(.success(PostComment(comments: [], user: user)))
            }

            guard let comments = dictionary["Comments"] as? [String: AnyObject] else {
                return handler(.success(PostComment(comments: [], user: user)))
            }

            let commentsFromDB = comments.values.compactMap { value -> [String: AnyObject]? in
                value as? [String: AnyObject]
            }.compactMap { element -> Comment? in
                guard let text = element["Text"] as? String,
                      let userId = element["UserID"] as? String,
                      let timeStamp = element["TimeStamp"] as? Double,
                      let likesUserIds = element["Likes"] as? [String] else {
                    return nil
                }

                return Comment(
                    text: text,
                    user: UserComment(id: userId, name: nil, photo: nil),
                    timeStamp: Date(timeIntervalSince1970: timeStamp),
                    numberOfLikes: likesUserIds.count
                )
            }

            var commentsWithUsers = [Comment]()
            var users = Set<UserComment>()
            users.insert(user)

            commentsFromDB.forEach { comment in
                if !users.contains(where: { user in comment.user.id == user.id }) {
                    get(userId: comment.user.id) { result in
                        if let user = try? result.get() {
                            users.insert(user)

                            commentsWithUsers.append(
                                Comment(
                                    text: comment.text,
                                    user: user,
                                    timeStamp: comment.timeStamp,
                                    numberOfLikes: comment.numberOfLikes
                                )
                            )
                        }
                    }
                } else if let user = users.first(where: { user in user.id == comment.user.id }) {
                    commentsWithUsers.append(
                        Comment(
                            text: comment.text,
                            user: user,
                            timeStamp: comment.timeStamp,
                            numberOfLikes: comment.numberOfLikes
                        )
                    )
                }
            }

            let commentsOrderedByTimeStamp = commentsWithUsers.sorted { (lhs, rhs) -> Bool in
                lhs.timeStamp < rhs.timeStamp
            }

            handler(.success(PostComment(comments: commentsOrderedByTimeStamp, user: user)))
        }
    }

    private func get(userId: String, then handler: @escaping (Result<UserComment, Error>) -> ()) {
        databaseReference.child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists(), let dictionary = snapshot.value as? [String: AnyObject] else {
                return handler(.failure(ServiceError.notFound))
            }

            guard let id = dictionary["UserID"] as? String,
                  let name = dictionary["Name"] as? String,
                  let photo = dictionary["profileUrl"] as? String else {
                return handler(.failure(ServiceError.parse))
            }

            handler(.success(UserComment(id: id, name: name, photo: photo)))
        }
    }

    func add(text: String, then handler: @escaping (Result<Void, Error>) -> ()) {

    }
}
