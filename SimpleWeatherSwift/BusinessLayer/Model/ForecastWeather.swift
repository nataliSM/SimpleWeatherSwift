//
//  ForecastWeather.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 25.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import Foundation

struct ForecastWeather: Codable {
    var date: Date
    var maxTemp: Int
    var minTemp: Int

    enum CodingKeys: String, CodingKey {
        case date
        case maxTemp = "maxtemp_c"
        case minTemp = "mintemp_c"
    }
}
