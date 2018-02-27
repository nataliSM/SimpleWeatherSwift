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
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib.init(nibName: String(describing: CurrentForecastCell.self), bundle: .main), forCellReuseIdentifier: CurrentForecastCell.reuseIdentifier())
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.input.loadWeatherData()
    }
    
    private func bind() {
        viewModel.output.weaters.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CurrentForecastCell.reuseIdentifier(), cellType: CurrentForecastCell.self)) {
                (index, weather: Weather, cell) in
                cell.configure(cityName: weather.city.name, temperature: weather.curentForecast.temp, imageLink: nil)
            }
            .disposed(by: disposeBag)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
