//
//  FirebaseRealtimeDatabaseLegendService.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 06/12/20.
//

import Firebase
import FirebaseDatabase

final class FirebaseRealtimeDatabaseLegendService: LegendService {
    private let databaseReference: DatabaseReference

    enum LegendServiceError: Error {
        case userNotLogged
        case idNotGenerated
        case imageDataNotAvailable
        case urlNotGenerated
    }

    static let shared: LegendService = FirebaseRealtimeDatabaseLegendService()

    private init() {
        databaseReference = Database.database().reference()
    }

    func add(legend: PostUser, for image: UIImage, usingWeather weatherType: String, then handler: @escaping (Result<PostUser, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {
            return handler(.failure(LegendServiceError.userNotLogged))
        }

        let newChild = databaseReference.child("posts").childByAutoId()

        guard let key = newChild.key else {
            return handler(.failure(LegendServiceError.idNotGenerated))
        }

        upload(image: image, forKey: key) { result in
            do {
                let url = try result.get()
                let value = [
                    "UserId": user.uid,
                    "ImageUrl": url.absoluteString,
                    "City": legend.city ?? "",
                    "Weather": legend.temperature ?? "",
                    "Caption": legend.comments ?? "",
                    "WeatherType": legend.temperature == nil || legend.temperature?.isEmpty == true ? "" : weatherType,
                    "TimeStamp": Date().timeIntervalSince1970
                ] as [String : Any]

                newChild.setValue(value) { (error, ref) in
                    if let error = error {
                        return handler(.failure(error))
                    }

                    handler(.success(legend))
                }
            } catch {
                handler(.failure(error))
            }
        }
    }

    private func upload(image: UIImage, forKey key: String, then handler: @escaping (Result<URL, Error>) -> ()){
        guard let imgData = image.pngData() else {
            return handler(.failure(LegendServiceError.imageDataNotAvailable))
        }

        let storageRef = Storage.storage().reference().child("\(key).png")
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"

        storageRef.putData(imgData, metadata: metaData) { (metadata, error) in
            if let error = error {
                return handler(.failure(error))
            }

            storageRef.downloadURL { (url, error) in
                if let error = error {
                    return handler(.failure(error))
                }

                guard let url = url else {
                    return handler(.failure(LegendServiceError.urlNotGenerated))
                }

                return handler(.success(url))

            }
        }
    }
}
