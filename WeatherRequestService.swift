//
//  WeatherRequestService.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 01.02.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

import UIKit

class WeatherRequestService: NSObject {
    
    private let url = "http://api.openweathermap.org/data/2.5/weather?appid=6dd4e82d58639fe3edf0e4cbecdafdc5"
    
    
    
    func getWeatherByCity(cityName:String, succesBlock:@escaping (_ result:String) -> ())
    {
        let str : String = "&q="
        let  fullUrlString = url + str + cityName
        let request = URL(string: fullUrlString)!
        URLSession.shared.dataTask(with: request) { (data,response, error) in
        
            if error != nil
            {
                print(error!)
            }else
            {
                do
                {
                
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let main = parsedData["main"] as! [String:Any]
                    
                    
                    let currentTemperatureF = main["temp"] as! Double
                    let temp = "\(currentTemperatureF)"
                    DispatchQueue.main.async {
                         succesBlock(temp)
                    }
                   
                } catch let error as NSError {
                    print(error)
                }
            }
                
            }.resume()
    }
            
           
        
            
}

     

