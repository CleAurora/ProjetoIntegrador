//
//  FirebaseRealtimeDatabaseFeedService.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 07/12/20.
//

import Firebase
import FirebaseDatabase

final class FirebaseRealtimeDatabaseFeedService: FeedService {
    private let databaseReference: DatabaseReference

    static let shared: FeedService = FirebaseRealtimeDatabaseFeedService()

    private init() {
        databaseReference = Database.database().reference()
    }

    enum FeedServiceError: Error {
        case userNotLogged
        case userNotFound
        case idNotGenerated
        case imageDataNotAvailable
        case urlNotGenerated
    }

    func getUser(then handler: @escaping (Result<Profile, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            return handler(.failure(FeedServiceError.userNotLogged))
        }

        databaseReference.child("users").child(user.uid).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists(), let dictionary = snapshot.value as? [String: AnyObject] else {
                return handler(.failure(FeedServiceError.userNotFound))
            }

            handler(
                .success(
                    Profile(
                        name: dictionary["Nickname"] as? String ?? "",
                        profileImage: dictionary["profileUrl"] as? String ?? "",
                        bio: dictionary["Bio"] as? String ?? ""
                    )
                )
            )
        }
    }

    func load(then handler: @escaping (Result<[PostUser], Error>) -> Void) {
        databaseReference.child("posts").observe(.value) { snapshot in
            guard snapshot.exists(), let dictionary = snapshot.value as? NSDictionary else {
                return handler(.success([]))
            }

            let posts = dictionary.allValues.compactMap{ value -> [String: AnyObject]? in
                return value as? [String: AnyObject]
            }.compactMap { element -> PostUser? in
                guard let userId = element["UserId"] as? String,
                      let imageUrl = element["ImageUrl"] as? String,
                      let city = element["City"] as? String,
                      let weather = element["Weather"] as? String,
                      let caption = element["Caption"] as? String,
                      let weatherType = element["WeatherType"] as? String
                else {
                    return nil
                }

                return PostUser(
                    userId: userId,
                    city: city,
                    temperature: weather,
                    weatherType: weatherType,
                    imagePostUrl: imageUrl,
                    comments: caption
                )
            }

            var users = [User]()
            var usersIdsRecovered = Set<String>()

            let usersIds = Set(posts.map({ post in post.user.id }))

            usersIds.enumerated().forEach { index, userId in
                self.databaseReference.child("users").child(userId).observeSingleEvent(of: .value) { userSnapshot in
                    if userSnapshot.exists(), let dictionary = userSnapshot.value as? [String: AnyObject],
                       let name = dictionary["Name"] as? String,
                       let imageProfileUrl = dictionary["profileUrl"] as? String {
                        users.append(User(id: userId, name: name, imageProfileUrl: imageProfileUrl))
                    }

                    usersIdsRecovered.insert(userId)

                    if usersIdsRecovered.count == usersIds.count {
                        let postsWithUsers = posts.compactMap { post -> PostUser? in
                            guard let user = users.first(where: { user in user.id == post.user.id }) else {
                                return nil
                            }

                            return PostUser(source: post, user: user)
                        }

                        handler(.success(postsWithUsers.reversed()))
                    }
                }
            }
        }
    }
}
