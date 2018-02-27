//
//  WeatherRequestService.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 01.02.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

import UIKit
import  RxCocoa
import  RxSwift
import RealmSwift

class WeatherRequestService: NSObject {
    
    private let rootPath = "https://api.apixu.com/v1/" 
    private let keyVariable = "key=17f9368288dc487d91f173516182502"
    private let searchPath = "search.json"
    private let currentWeatherPath = "current.json"

    
    func saveCity(_ city: City) {
        let cityEntity = CityEntity()
        cityEntity.name = city.name
        cityEntity.country = city.country
        cityEntity.region = city.region
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(cityEntity)
        }
    }
    
    func fetchSavedCities() -> Observable<[City]> {
        return Observable.create { (subscriber) in
            do {
                let realm = try Realm()
                let cities = Array(realm.objects(CityEntity.self)).map({ (entry) -> City in
                    return City(name: entry.name, region: entry.region, country: entry.country)
                })
                subscriber.onNext(cities)
                subscriber.onCompleted()
            } catch (let error) {
                subscriber.onError(error)
                subscriber.onCompleted()
            }
            return Disposables.create()
            
        }.observeOn(MainScheduler.instance)
    }
    
    func fetchCityWeather(_ city: City) -> Observable<Weather> {
        let name = city.name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let fullUrlString = "\(rootPath)\(currentWeatherPath)?\(keyVariable)&q=\(name ?? "")"
        let fullUrl = URL(string: fullUrlString)!
        let urlSession = URLSession.shared
        return urlSession.rx.data(request:URLRequest(url: fullUrl))
            .map { data -> Weather in
                let decoder = JSONDecoder()
                let weather = try! decoder.decode(Weather.self, from: data)
                return weather
            }
            .observeOn(MainScheduler.instance)
    }
            
    func fetchCitiesBy(name: String) -> Observable<[City]> {
        let fullUrl = URL(string:"\(rootPath)\(searchPath)?\(keyVariable)&q=\(name)")!
        let urlSession = URLSession.shared
        return urlSession.rx.data(request:URLRequest(url: fullUrl))
            .map { data -> [City] in
                let decoder = JSONDecoder()
                let cities = try! decoder.decode([City].self, from: data)
                return cities
            }
            .observeOn(MainScheduler.instance)

    }

            
}

     

