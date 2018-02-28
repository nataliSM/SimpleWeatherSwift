//
//  CurrentForecastCell.swift
//  SimpleWeatherSwift
//
//  Created by Никита Солдатов on 27.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import UIKit

class CurrentForecastCell: UITableViewCell {
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var conditionsImageView: UIImageView!
    
    class func reuseIdentifier() -> String {
        return String(describing: CurrentForecastCell.self)
    }

    func configure(cityName: String, temperature: Double, imageLink: URL?) {
        self.cityNameLabel.text = cityName
        self.temperatureLabel.text = "\(temperature)\u{00B0}"
    }
    
}
