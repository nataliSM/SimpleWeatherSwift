//
//  ViewController.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 01.02.17.
//  Copyright © 2017 IOSLab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListViewModelType = ListViewModel() 
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.loadWeatherData()
    }
    
    
    private func bind() {
        viewModel.output.weaters.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "WeatherCell")) {
                (index, weather: Weather, cell) in
                cell.textLabel?.text = weather.city.name
                cell.detailTextLabel?.text = "\(weather.curentForecast.temp)"
            }
            .disposed(by: disposeBag)
    }
}
