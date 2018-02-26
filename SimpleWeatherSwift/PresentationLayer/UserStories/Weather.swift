//
//  Weather.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 25.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var curentTemp: Int
    var city: City

    enum CodingKeys: String, CodingKey {
        case city
        case curentTemp = "temp_c"
    }
}
