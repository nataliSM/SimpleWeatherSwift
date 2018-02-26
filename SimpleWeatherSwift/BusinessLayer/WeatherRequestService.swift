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

class WeatherRequestService: NSObject {
    
    private let url = "https://api.apixu.com/v1/search.json?key=17f9368288dc487d91f173516182502"
    private let imageURL = "http://www.dnepr-333.dp.ua/favicon.png"
    

            
    func fetchCitiesBy(name: String) -> Observable<[City]> {
        let fullUrl = URL(string:"\(url)&q=\(name)")!
        let urlSession = URLSession.shared
        return urlSession.rx.data(request:URLRequest(url: fullUrl)).map { data -> [City] in
            let decoder = JSONDecoder()
            let cities = try! decoder.decode([City].self, from: data)
            return cities
        }.observeOn(MainScheduler.instance)

    }

            
}

     

