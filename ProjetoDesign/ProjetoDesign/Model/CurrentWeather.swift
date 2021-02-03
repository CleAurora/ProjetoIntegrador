//
//  CurrentWeather.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-11-29.
//

struct WeatherResult: Decodable {
    let name: String
    let weather: [Weather]
    let main: Temperature
}

struct Weather: Decodable {
    let main: String
}

struct Temperature: Decodable {
    let temp: Double
}

struct WeatherViewModel {
    let cityName: String
    let weatherType: String
    let currentTemperature: Double

    // MARK: - Initializer

    init(cityName: String, weatherType: String, currentTemperature: Double) {
        self.cityName = cityName
        self.weatherType = weatherType
        self.currentTemperature = currentTemperature
    }

    init(from weatherResult: WeatherResult) {
        self.init(
            cityName: weatherResult.name,
            weatherType: weatherResult.weather.first?.main ?? "",
            currentTemperature: weatherResult.main.temp
        )
    }
}
