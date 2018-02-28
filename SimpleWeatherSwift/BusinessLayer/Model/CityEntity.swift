//
//  RLMCity.swift
//  SimpleWeatherSwift
//
//  Created by Никита Солдатов on 26.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import Foundation
import RealmSwift

class CityEntity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var region: String = ""
    @objc dynamic var country: String = ""
    
}
