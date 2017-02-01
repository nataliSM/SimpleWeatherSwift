//
//  ViewController.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 01.02.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var  resultWeather : String?
    
    @IBOutlet weak var cityText: UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func buttonDidClicked(_ sender: UIButton)
    {
       let service = WeatherRequestService()
       service.getWeatherByCity(cityName: cityText.text!) { (result: String) in
        
               self.resultWeather = result
                self .performSegue(withIdentifier: "segue", sender: Any?.self)
        }
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
           
      
           let dest = segue.destination as! DetailViewController
            dest.weather = resultWeather
            
        }
        

        }

    }


