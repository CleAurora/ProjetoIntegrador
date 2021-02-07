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
    private var feeds: [PostUser] = []

    private var newPostsCancellationToken: UInt?
    private var postsChangedCancellationToken: UInt?

    static let shared: FeedService = FirebaseRealtimeDatabaseFeedService()

    private init() {
        databaseReference = Database.database().reference()
    }

    enum FeedServiceError: Error {
        case userNotLogged
        case userNotFound
        case likeNotFound
        case idNotGenerated
        case imageDataNotAvailable
        case urlNotGenerated
    }

    // MARK: - FeedService conformance

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
                        bio: dictionary["Bio"] as? String ?? "",
                        uid: dictionary["UserID"] as? String ?? ""
                    )
                )
            )
        }
    }

    func like(postId: String, then handler: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return handler(.failure(FeedServiceError.userNotLogged))
        }

        let value = [
            "UserID": currentUser.uid,
            "TimeStamp": Date().timeIntervalSince1970
        ] as [String : Any]

        databaseReference.child("posts").child(postId).child("Likes").observeSingleEvent(of: .value) { [self] snapshot in
            guard snapshot.exists(), let dictionary = snapshot.value as? [String: AnyObject] else {
                return databaseReference.child("posts").child(postId).child("Likes").childByAutoId()
                    .setValue(value) { (error, ref) in
                        guard let error = error else {
                            return handler(.success(()))
                        }

                        return handler(.failure(error))
                    }
            }

            let likeId = dictionary.first { (key, value) -> Bool in
                guard let valueDictionary = value as? [String: AnyObject],
                      let userId = valueDictionary["UserId"] as? String else {
                    return false
                }

                return userId == currentUser.uid
            }.map({ key, _ in key })

            guard likeId == nil else {
                return handler(.success(()))
            }

            databaseReference.child("posts").child(postId).child("Likes").childByAutoId().setValue(value) { (error, ref) in
                guard let error = error else {
                    return handler(.success(()))
                }

                return handler(.failure(error))
            }
        }
    }

    func dislike(postId: String, then handler: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return handler(.failure(FeedServiceError.userNotLogged))
        }

        databaseReference.child("posts").child(postId).child("Likes").observeSingleEvent(of: .value) { [self] snapshot in
            guard snapshot.exists(), let dictionary = snapshot.value as? [String: AnyObject] else {
                return handler(.failure(FeedServiceError.userNotFound))
            }

            let likeId = dictionary.first { (key, value) -> Bool in
                guard let valueDictionary = value as? [String: AnyObject],
                      let userId = valueDictionary["UserID"] as? String else {
                    return false
                }

                return userId == currentUser.uid
            }.map({ key, _ in key })

            guard let id = likeId else {
                return handler(.failure(FeedServiceError.likeNotFound))
            }

            databaseReference.child("posts").child(postId).child("Likes").child(id).removeValue { (error, ref) in
                guard let error = error else {
                    return handler(.success(()))
                }

                return handler(.failure(error))
            }
        }
    }

    func load(then handler: @escaping (Result<[PostUser], Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            return handler(.failure(FeedServiceError.userNotLogged))
        }

        databaseReference.child("users").child(user.uid).observeSingleEvent(of: .value) { [self] snapshot in
            loadPosts(userUid: user.uid, snapshot: snapshot, then: handler)
        }

        databaseReference.child("users").child(user.uid).observe(.value) { [self] snapshot in
            loadPosts(userUid: user.uid, snapshot: snapshot, then: handler)
        }
    }

    // MARK: - Private functions

    private func loadPosts(userUid: String, snapshot: DataSnapshot, then handler: @escaping (Result<[PostUser], Error>) -> Void) {
        guard snapshot.exists(), let dictionary = snapshot.value as? [String: AnyObject] else {
            return handler(.failure(FeedServiceError.userNotFound))
        }

        var usersFollowing = [userUid]

        if let followingUsers = dictionary["following"] as? NSDictionary {
            usersFollowing.append(contentsOf: followingUsers.allKeys.compactMap({ anyKey in anyKey as? String }))
        }

        if let newPostsCancellationToken = newPostsCancellationToken {
            databaseReference.removeObserver(withHandle: newPostsCancellationToken)
        }

        if let postsChangedCancellationToken = postsChangedCancellationToken {
            databaseReference.removeObserver(withHandle: postsChangedCancellationToken)
        }

        loadPosts(followingUsers: usersFollowing, then: handler)
    }

    private func loadPosts(followingUsers: [String], then handler: @escaping (Result<[PostUser], Error>) -> Void) {
        databaseReference.child("posts").queryOrdered(byChild: "TimeStamp").observeSingleEvent(of: .value, with: { [self] dataSnapshot in
            convert(followingUsers: followingUsers, snapshot: dataSnapshot, then: handler)
            waitForNewPosts(following: followingUsers, then: handler)
        }, withCancel: { error in
            handler(.failure(error))
        })
    }

    private func convert(followingUsers: [String], snapshot: DataSnapshot, then handler: @escaping (Result<[PostUser], Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            return handler(.failure(FeedServiceError.userNotLogged))
        }

        guard snapshot.exists(), snapshot.hasChildren(), let dictionary = snapshot.value as? NSDictionary else {
            return handler(.success(feeds))
        }

        let newPosts: [PostUser]

        if dictionary["ImageUrl"] != nil, let element = dictionary as? [String: AnyObject],
           let userId = element["UserId"] as? String, followingUsers.contains(userId) {
            if let userId = element["UserId"] as? String,
                  let imageUrl = element["ImageUrl"] as? String,
                  let city = element["City"] as? String,
                  let weather = element["Weather"] as? String,
                  let caption = element["Caption"] as? String,
                  let weatherType = element["WeatherType"] as? String,
                  let timestamp = element["TimeStamp"] as? Double
            {
                let numberOfComments: Int
                let numberOfLikes: Int
                let isLiked: Bool

                if let likes = element["Likes"] as? [String: AnyObject] {
                    let likeId = likes.first { (key, value) -> Bool in
                        guard let valueDictionary = value as? [String: AnyObject],
                              let userIdOnDictionary = valueDictionary["UserID"] as? String else {
                            return false
                        }

                        return user.uid == userIdOnDictionary
                    }.map({ key, _ in key })

                    isLiked = likeId != nil
                    numberOfLikes = likes.count
                } else {
                    numberOfLikes = 0
                    isLiked = false
                }

                if let comments = element["Comments"] as? [String: AnyObject] {
                    numberOfComments = comments.count
                } else {
                    numberOfComments = 0
                }

                newPosts = [
                    PostUser(
                        id: snapshot.key,
                        userId: userId,
                        timestamp: Date(timeIntervalSince1970: timestamp),
                        city: city,
                        temperature: weather,
                        weatherType: weatherType,
                        imagePostUrl: imageUrl,
                        comments: caption,
                        numberOfComments: numberOfComments,
                        numberOfLikes: numberOfLikes,
                        isLiked: isLiked
                    )
                ]
            } else {
                newPosts = []
            }
        } else {
            newPosts = dictionary.compactMap { (key, value) -> PostUser? in
                guard let id = key as? String,
                      let element = value as? [String: AnyObject],
                      let userId = element["UserId"] as? String,
                      let imageUrl = element["ImageUrl"] as? String,
                      let city = element["City"] as? String,
                      let weather = element["Weather"] as? String,
                      let caption = element["Caption"] as? String,
                      let weatherType = element["WeatherType"] as? String,
                      let timestamp = element["TimeStamp"] as? Double,
                      followingUsers.contains(userId)
                else {
                    return nil
                }

                let numberOfComments: Int
                let numberOfLikes: Int
                let isLiked: Bool

                if let likes = element["Likes"] as? [String: AnyObject] {
                    numberOfLikes = likes.count

                    let likeId = likes.first { (key, value) -> Bool in
                        guard let valueDictionary = value as? [String: AnyObject],
                              let userIdOnDictionary = valueDictionary["UserID"] as? String else {
                            return false
                        }

                        return user.uid == userIdOnDictionary
                    }.map({ key, _ in key })

                    isLiked = likeId != nil
                } else {
                    isLiked = false
                    numberOfLikes = 0
                }

                if let comments = element["Comments"] as? [String: AnyObject] {
                    numberOfComments = comments.count
                } else {
                    numberOfComments = 0
                }

                return PostUser(
                    id: id,
                    userId: userId,
                    timestamp: Date(timeIntervalSince1970: timestamp),
                    city: city,
                    temperature: weather,
                    weatherType: weatherType,
                    imagePostUrl: imageUrl,
                    comments: caption,
                    numberOfComments: numberOfComments,
                    numberOfLikes: numberOfLikes,
                    isLiked: isLiked
                )
            }
        }

        var users = [User]()
        var usersIdsRecovered = Set<String>()

        let usersIds = Set(newPosts.map({ post in post.user.id }))

        usersIds.enumerated().forEach { index, userId in
            databaseReference.child("users").child(userId).observeSingleEvent(of: .value) { [self] userSnapshot in
                if userSnapshot.exists(), let dictionary = userSnapshot.value as? [String: AnyObject],
                   let name = dictionary["Name"] as? String,
                   let imageProfileUrl = dictionary["profileUrl"] as? String {
                    users.append(User(id: userId, name: name, imageProfileUrl: imageProfileUrl))
                }

                usersIdsRecovered.insert(userId)

                if usersIdsRecovered.count == usersIds.count {
                    let newPosts = newPosts.compactMap { post -> PostUser? in
                        guard let user = users.first(where: { user in user.id == post.user.id }) else {
                            return nil
                        }

                        return PostUser(source: post, user: user)
                    }

//                    let cached = feeds
//                    let newListFiltered = newPosts.filter({ newPost in !cached.contains(newPost) })
//                    let newList = newListFiltered + cached.filter({ old in newListFiltered.isEmpty || newListFiltered.contains(where: { new in new.id == old.id }) })
                    feeds.removeAll(where: { old in newPosts.contains(where: { new in new.id == old.id }) })
                    let newList = newPosts + feeds
                    let filteredList = newList.filter({ post in followingUsers.contains(post.user.id) }).sorted(by: { (lhsPost, rhsPost) -> Bool in
                        guard let lhsDate = lhsPost.timestamp, let rhsDate = rhsPost.timestamp else {
                            return false
                        }

                        return lhsDate > rhsDate
                    })

                    if feeds != filteredList {
                        feeds = filteredList

                        handler(.success(filteredList))
                    }
                }
            }
        }
    }

    private func waitForNewPosts(following: [String], then handler: @escaping (Result<[PostUser], Error>) -> Void) {
        newPostsCancellationToken = databaseReference.child("posts").observe(.childAdded) { [self] dataSnapshot in
            convert(followingUsers: following, snapshot: dataSnapshot, then: handler)
        } withCancel: { error in
            handler(.failure(error))
        }

        postsChangedCancellationToken = databaseReference.child("posts").observe(.childChanged) { [self] dataSnapshot in
            convert(followingUsers: following, snapshot: dataSnapshot, then: handler)
        } withCancel: { error in
            handler(.failure(error))
        }
    }
}
