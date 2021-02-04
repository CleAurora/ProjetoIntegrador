//
//  LegendViewModelSpy.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 04/02/21.
//

@testable import ProjetoDesign

final class LegendViewModelSpy: LegendViewModelProtocol {
    var invokedCurrentWeatherGetter = false
    var invokedCurrentWeatherGetterCount = 0
    var stubbedCurrentWeather: WeatherViewModel!

    var currentWeather: WeatherViewModel? {
        invokedCurrentWeatherGetter = true
        invokedCurrentWeatherGetterCount += 1
        return stubbedCurrentWeather
    }

    var invokedGetCurrentTemperature = false
    var invokedGetCurrentTemperatureCount = 0
    var stubbedGetCurrentTemperatureHandlerResult: (Result<Void, Error>, Void)?

    func getCurrentTemperature(then handler: @escaping (Result<Void, Error>) -> Void) {
        invokedGetCurrentTemperature = true
        invokedGetCurrentTemperatureCount += 1
        if let result = stubbedGetCurrentTemperatureHandlerResult {
            handler(result.0)
        }
    }

    var invokedPost = false
    var invokedPostCount = 0
    var invokedPostParameters: (input: NewPostViewModel, Void)?
    var invokedPostParametersList = [(input: NewPostViewModel, Void)]()

    func post(_ input: NewPostViewModel) {
        invokedPost = true
        invokedPostCount += 1
        invokedPostParameters = (input, ())
        invokedPostParametersList.append((input, ()))
    }
}
