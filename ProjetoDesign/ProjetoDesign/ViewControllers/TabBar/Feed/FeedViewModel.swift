//
//  FeedViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 08/12/20.
//

import UIKit
import PKHUD

protocol FeedViewModelProtocol {
    var posts: [PostUser] { get }
    var currentUser: Profile? { get }
    var error: Error? { get }

    func getCurrentUser(then handler: @escaping (Profile) -> Void)
    func like(postId: String, then handler: @escaping () -> Void)
    func dislike(postId: String, then handler: @escaping () -> Void)
    func load(then handler: @escaping () -> Void)
}

final class FeedViewModel: FeedViewModelProtocol {
    private let service: FeedService
    private weak var viewController: UIViewController?

    private(set) var posts = [PostUser]()
    private(set) var currentUser: Profile? = nil
    private(set) var error: Error? = nil

    init(service: FeedService = FirebaseRealtimeDatabaseFeedService.shared, for viewController: UIViewController) {
        self.service = service
        self.viewController = viewController
    }

    func getCurrentUser(then handler: @escaping (Profile) -> Void) {
        error = nil

        HUD.show(.progress)

        service.getUser { [weak self] result in
            HUD.hide()
            do {
                let profile = try result.get()

                self?.currentUser = profile

                handler(profile)
            } catch {
                self?.show(error: error)
            }
        }
    }

    func load(then handler: @escaping () -> Void) {
        error = nil

        HUD.show(.progress)

        service.load { [weak self] result in
            do {
                self?.posts = try result.get()
            } catch {
                self?.show(error: error)
            }

            HUD.hide()
            handler()
        }
    }

    func like(postId: String, then handler: @escaping () -> Void) {
        error = nil

        HUD.show(.progress)

        service.like(postId: postId) { [weak self] result in
            do {
                try result.get()
                handler()
            } catch {
                self?.show(error: error)
            }

            HUD.hide()
        }
    }

    func dislike(postId: String, then handler: @escaping () -> Void) {
        error = nil

        HUD.show(.progress)

        service.dislike(postId: postId) { [weak self] result in
            do {
                try result.get()
                handler()
            } catch {
                self?.show(error: error)
            }

            HUD.hide()
        }
    }

    // MARK: - Private functions

    private func show(error: Error) {
        self.error = error

        let alertController = UIAlertController(
            title: "Erro ao carregar informações", message: error.localizedDescription, preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        viewController?.present(alertController, animated: true, completion: nil)
    }
}
