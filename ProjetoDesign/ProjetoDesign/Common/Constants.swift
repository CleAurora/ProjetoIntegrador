//
//  Constants.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 03/02/21.
//

enum Constants {
    static func getApiUrl(latitude: Double, longitude: Double) -> String {
        "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=a0c484c7ab240f57f26aea649e95fd64&units=metric"
    }
}
