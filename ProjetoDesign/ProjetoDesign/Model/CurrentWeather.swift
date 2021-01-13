//
//  CurrentWeather.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-11-29.
//
import Foundation
import Alamofire
import SwiftyJSON
// SwiftyJSON helps to read and process JSON
class CurrentWeather{

    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!

    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }

        return _cityName
    }

    var date: String {
        if _date == nil {
            _date = ""
        }

        return _date
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }

        return _weatherType
    }

    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0
        }

        return _currentTemp
    }

    private(set) var hasTemperature: Bool = false

    func downloadCurrentWeather(completed: @escaping DownloadComplete){
        //the code below will allow you to request API using Alamofire and get the result when it is completed.
        AF.request(API_URL).responseJSON { [self] (response) in
            if let data = response.data {
                let jsonObject = JSON(data)
                _cityName = jsonObject["name"].stringValue
                _weatherType = jsonObject["weather"][0]["main"].stringValue

                let tempDate=jsonObject["dt"].double
                let convertedUnixDate = Date(timeIntervalSince1970: tempDate!)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                let currentDate = dateFormatter.string(from: convertedUnixDate)
                _date = currentDate

                let downloadedTemp = jsonObject["main"]["temp"].double
                let tmp = downloadedTemp! - 273.15
                _currentTemp = tmp
                hasTemperature = true

                // The code below is just to see more info about our API
                print(_cityName!)
                print(_date!)
                print(_currentTemp!)
                print(_weatherType!)
            }

            completed()
        }
    }
}
