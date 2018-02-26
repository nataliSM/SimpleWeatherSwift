//
//  SearchController.swift
//  SimpleWeatherSwift
//
//  Created by Наталья on 25.02.2018.
//  Copyright © 2018 IOSLab. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController:UIViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    var cities: Array<City> = []
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        bind()
    }

    private func bind() {
        self.viewModel.cities.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "CityCell")) {
            (index, repository: City, cell) in
            cell.textLabel?.text = repository.name
        }.disposed(by: disposeBag)

        self.searchController.searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { text in
            self.viewModel.fetchCities(name: text)
        }).disposed(by: disposeBag)
    }
}

