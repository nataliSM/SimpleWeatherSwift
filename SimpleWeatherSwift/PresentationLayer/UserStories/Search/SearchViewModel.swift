//
//  SearchViewModel.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 25.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel {

    let service = WeatherRequestService()
    let cities: Variable<[City]> = Variable([])

    
    func fetchCities(name: String) {
        var cities = service.fetchCitiesBy(name: name)
        cities.subscribe(onNext: { (cities) in
            self.cities.value = cities
        }, onError: { (error) in
            
        })
    }
}
