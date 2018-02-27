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

class SearchViewController:UIViewController, UISearchControllerDelegate, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var cities: Array<City> = []
    let viewModel: SearchViewModelType = SearchViewModel()
    let disposeBag = DisposeBag()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        bind()
    }

    private func bind() {
        self.viewModel.output.cities.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "CityCell")) {
            (index, repository: City, cell) in
            cell.textLabel?.text = repository.name
        }.disposed(by: disposeBag)

        self.searchController.searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { text in
            self.viewModel.input.fetchCities(name: text)
        }).disposed(by: disposeBag)
    }

    func willDismissSearchController(_ searchController: UISearchController){
        self.viewModel.output.cities.value = []
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.saveCity(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}

