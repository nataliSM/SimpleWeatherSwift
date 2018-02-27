//
//  SearchViewModel.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 25.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SearchviewModelInput {

    func fetchCities(name: String)

    func saveCity(indexPath: IndexPath)
}

protocol SearchViewModelOutput {
    var cities: Variable<[City]> { get }
}

protocol SearchViewModelType {
    var input: SearchviewModelInput { get }
    var output: SearchViewModelOutput { get }
}

class SearchViewModel: SearchViewModelOutput, SearchviewModelInput, SearchViewModelType {

    var input: SearchviewModelInput { return self }
    var output: SearchViewModelOutput { return self }
    private let service = WeatherRequestService()
    private var disposeBag = DisposeBag()
    var cities: Variable<[City]> = Variable([])

    
    func fetchCities(name: String) {
        let cities = service.fetchCitiesBy(name: name)
        cities.subscribe(onNext: { (cities) in
            self.cities.value = cities
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }

    func saveCity(indexPath: IndexPath) {
        let city = cities.value[indexPath.row]
        service.saveCity(city)
    }
}
