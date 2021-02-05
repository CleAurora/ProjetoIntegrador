//
//  LegendViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 06/12/20.
//

import Alamofire
import CoreLocation
import PKHUD
import UIKit

struct NewPostViewModel {
    let hasPlace: Bool
    let hasTemperature: Bool
    let image: UIImage?
    let comment: String?
}

protocol LegendViewModelProtocol {
    var currentWeather: WeatherViewModel? { get }

    func getCurrentTemperature(then handler: @escaping (Result<Void, Error>) -> Void)
    func post(_ input: NewPostViewModel)
}

final class LegendViewModel: NSObject, LegendViewModelProtocol, CLLocationManagerDelegate {
    private let service: LegendService
    private let locationManager: CLLocationManager = CLLocationManager()

    // MARK: - Weak variables

    private weak var viewController: UIViewController?

    // MARK: - Private variables

    private var currentTemperatureHandlerClosure: ((Result<Void, Error>) -> Void)?

    // MARK: - Initializer

    init(service: LegendService = FirebaseRealtimeDatabaseLegendService.shared, for viewController: UIViewController) {
        self.service = service
        self.viewController = viewController
    }

    // MARK: - Enum

    enum LocationError: Error {
        case notFound
        case notAuthorized
    }

    // MARK: - LegendViewModelProtocol conformance

    private(set) var currentWeather: WeatherViewModel?

    func getCurrentTemperature(then handler: @escaping (Result<Void, Error>) -> Void) {
        if currentWeather != nil {
            return handler(.success(()))
        }

        currentTemperatureHandlerClosure = handler

        if isLocationAuthorized() {
            getWeatherFromCurrentLocation()
        } else if locationManager.authorizationStatus == .notDetermined {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        } else {
            handler(.failure(LocationError.notAuthorized))
        }
    }

    func post(_ input: NewPostViewModel) {
        if let image = input.image {
            let weatherType: String
            let postUser: PostUser

            if let weather = currentWeather {
                let temperature = String(format: "%.0f", round(weather.currentTemperature))

                weatherType = weather.weatherType
                postUser = PostUser(
                    city: input.hasPlace ? weather.cityName : nil,
                    temperature: input.hasTemperature ? temperature : nil,
                    weatherType: weather.weatherType,
                    comments: input.comment
                )
            } else {
                weatherType = ""
                postUser = PostUser(
                    comments: input.comment
                )
            }

            HUD.show(.progress)

            service.add(legend: postUser, for: image, usingWeather: weatherType.lowercased()) { [weak self] result in
                HUD.hide()

                do {
                    let result = try result.get()

                    self?.updateViewControllers(with: result, and: input)
                } catch {
                    self?.show(error: error)
                }
            }
        }
    }

    // MARK: - CLLocationManagerDelegate conforms

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if isLocationAuthorized() {
            getWeatherFromCurrentLocation()
        } else if locationManager.authorizationStatus != .notDetermined {
            currentTemperatureHandlerClosure?(.failure(LocationError.notAuthorized))
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint(#function, locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(#function, error)
        currentTemperatureHandlerClosure?(.failure(error))
    }

    // MARK: - Private functions

    private func isLocationAuthorized() -> Bool {
        locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways
    }

    private func getWeatherFromCurrentLocation() {
        requestLocation()

        if let location = locationManager.location {
            getCurrentWeather(from: location) { [self] result in
                currentWeather = try? result.get()

                currentTemperatureHandlerClosure?(.success(()))
            }
        } else {
            currentTemperatureHandlerClosure?(.failure(LocationError.notFound))
        }
    }

    private func requestLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestLocation()
    }

    private func getCurrentWeather(from location: CLLocation,
                                   then handler: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        let coordinates = location.coordinate
        let url = Constants.getApiUrl(latitude: coordinates.latitude, longitude: coordinates.longitude)

        HUD.show(.progress)

        AF.request(url).responseDecodable(of: WeatherResult.self) { dataResponse in
            HUD.hide(animated: true)

            do {
                let weatherResult = try dataResponse.result.get()

                handler(.success(WeatherViewModel(from: weatherResult)))
            } catch {
                handler(.failure(error))
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
            feedViewController.feedTableView.reloadData()
        }

        if let viewController = viewController, let tabBarController = viewController.tabBarController, let profileViewController = tabBarController.viewControllers?.last as? ProfileViewController {
            profileViewController.profileCollectionView?.reloadData()
        }

        viewController?.navigationController?.popViewController(animated: true)
    }
}
