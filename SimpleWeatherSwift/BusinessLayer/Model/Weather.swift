//
//  Weather.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 25.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import Foundation

struct CurrentForecast: Codable {
    var temp: Double
    var wind: Double
    var windDirrection: String
    var pressure: Double
    var feelsLike: Double
    var visibility: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case wind = "wind_kph"
        case windDirrection = "wind_dir"
        case pressure = "pressure_mb"
        case feelsLike = "feelslike_c"
        case visibility = "vis_km"
    }
}

struct Weather: Codable {
    var curentForecast: CurrentForecast 
    var city: City

    enum CodingKeys: String, CodingKey {
        case city = "location"
        case curentForecast = "current"
    }
}
