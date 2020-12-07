//
//  LegendViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 06/12/20.
//

import UIKit

struct NewPostViewModel {
    let weather: CurrentWeather
    let hasPlace: Bool
    let hasTemperature: Bool
    let image: UIImage?
    let imageName: String?
    let comment: String?
}

final class LegendViewModel {
    private let service: LegendService
    private weak var viewController: UIViewController?

    init(service: LegendService = FirebaseRealtimeDatabaseLegendService.shared, for viewController: UIViewController) {
        self.service = service
        self.viewController = viewController
    }

    func post(_ input: NewPostViewModel) {
        let imageName = input.imageName ?? ""

        if let image = input.image {
            let postUser = PostUser(
                name: "Melissa",
                city: input.hasPlace ? input.weather.cityName : nil,
                temperature: input.hasTemperature ? input.weather.currentTemp : nil,
                imageProfile: "mel0.jpg",
                imagePost: imageName,
                comments: input.comment ?? "",
                allImages: []
            )

            service.add(legend: postUser, for: image, usingWeather: input.weather.weatherType.lowercased()) { [weak self] result in
                do {
                    let result = try result.get()

                    self?.updateViewControllers(with: result, and: input)
                } catch {
                    self?.show(error: error)
                }
            }
        }
    }

    private func show(error: Error) {
        let alertController = UIAlertController(title: "Erro ao postar", message: error.localizedDescription, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        viewController?.present(alertController, animated: true, completion: nil)
    }

    private func updateViewControllers(with postUser: PostUser, and input: NewPostViewModel) {
        if let viewController = viewController, let tabBarController = viewController.tabBarController,
           let viewControllers = tabBarController.viewControllers,
           let navController = viewControllers.first as? UINavigationController,
           let feedViewController = navController.viewControllers.first as? FeedViewController {
            tabBarController.selectedIndex = 0
            feedViewController.postagem.insert(postUser, at: 0)
            feedViewController.feedTableView.reloadData()
        }

        if let viewController = viewController, let tabBarController = viewController.tabBarController, let profileViewController = tabBarController.viewControllers?.last as? ProfileViewController {
            profileViewController.imagensArray.append(ImagensProfile(imagens: postUser.imagePost, weatherImage: input.weather.weatherType.lowercased()))
            profileViewController.profileCollectionView?.reloadData()
        }

        viewController?.navigationController?.popViewController(animated: true)
    }
}
