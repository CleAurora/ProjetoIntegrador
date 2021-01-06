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
        case userNotFound
        case idNotGenerated
        case imageDataNotAvailable
        case urlNotGenerated
        case parse
    }

    static let shared: CommentsService = FirebaseRealtimeDatabaseCommentsService()

    private init() {
        databaseReference = Database.database().reference()
    }

    func get(postId: String, then handler: @escaping (Result<[Comment], Error>) -> ()) {
        
    }

    private func get(userId: String, then handler: @escaping (Result<UserComment, Error>) -> ()) {
        databaseReference.child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists(), let dictionary = snapshot.value as? [String: AnyObject] else {
                return handler(.failure(ServiceError.userNotFound))
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

    func like(commentId: String, then handler: @escaping (Result<Void, Error>) -> ()) {

    }

    func dislike(commentId: String, then handler: @escaping (Result<Void, Error>) -> ()) {

    }


}
