//
//  DetailViewController.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 01.02.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    var  weather : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempLabel.text = weather

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
