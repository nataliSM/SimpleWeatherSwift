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

    @IBOutlet weak var image: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        let service = WeatherRequestService()

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func buttonDidClicked(_ sender: UIButton)
    {
       let service = WeatherRequestService()
      
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
           
      
           let dest = segue.destination as! DetailViewController
            dest.weather = resultWeather
            
        }
        

        }

    }



