//
//  ListViewModel.swift
//  SimpleWeatherSwift
//
//  Created by Никита Солдатов on 26.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import Foundation
import RxSwift

protocol ListViewModelInput {
    func loadWeatherData()
    
}

protocol ListViewModelOutput {
    var weaters: Variable<[Weather]> { get }
}

protocol ListViewModelType {
    var input: ListViewModelInput { get }
    var output: ListViewModelOutput { get }
    
}

class ListViewModel: ListViewModelInput, ListViewModelOutput, ListViewModelType {
    var input: ListViewModelInput { return self }
    var output: ListViewModelOutput { return self }
    var weaters: Variable<[Weather]> = Variable([])
    private var disposeBag = DisposeBag()
    private let weatherService: WeatherRequestService = WeatherRequestService()
    
    func loadWeatherData() {
        weatherService.fetchSavedCities()
            .flatMap { (cities) -> Observable<[Weather]> in
                var observables: [Observable<Weather>] = []
                cities.forEach({ city in
                    observables.append(self.weatherService.fetchCityWeather(city))
                })
                return Observable.zip(observables)
            }
            .subscribe(onNext: { (weather) in
                self.weaters.value = weather
                    
            }).disposed(by: disposeBag)
    }
    
}
