//
//  PeopleController.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GenericTableViewController<VM: BaseViewModel>: UITableViewController {

    var viewModel: VM!
    var apiClient: APIClient!
    var jsonDecoder: JSONDecoder!
    let disposeBag = DisposeBag()
    var loadingScreenView = LoadingScreenView()

    @IBOutlet weak var searchBar: UISearchBar!

    weak var delegate: TabBarControllerDelegate?

    override func loadView() {
        super.loadView()
        
        setupLoadingScreen(loadingScreenView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingScreenView.showLoadingScreen()
        setupTableView()
        setupTableViewBindings()
    }

    func setupTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.tableFooterView = UIView()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    private func setupTableViewBindings() {
        viewModel.modelList
            // swiftlint:disable:next line_length
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.tabListTableViewCell.identifier, cellType: TabListTableViewCell.self)) { [ weak self ] (row, element, cell) in
                self?.customizeCell(cell, row, element)
                self?.loadingScreenView.hideLoadingScreen()
            }
            .disposed(by: disposeBag)

        tableView.rx.reachedBottom.asDriver()
            .drive(viewModel.nextPageTrigger)
            .disposed(by: disposeBag)

        searchBar.rx.text.orEmpty
            .debounce(0.2, scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(viewModel.filterSource)
            .disposed(by: disposeBag)
    }

    func setupLoadingScreen(_ loadingScreenView: LoadingScreenView) {
        view.addSubview(loadingScreenView)

        NSLayoutConstraint.activate([
            loadingScreenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingScreenView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func customizeCell(_ cell: TabListTableViewCell, _ row: Int, _ model: VM.Model) {
        if row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.9639316307, green: 0.9639316307, blue: 0.9639316307, alpha: 1)
        }

        cell.accessoryType = .disclosureIndicator

        setCellLabelContents(cell, model)
    }

    func setCellLabelContents(_ cell: TabListTableViewCell, _ model: VM.Model) {}
}

extension GenericTableViewController: DependenciesInjection {
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder) {
        self.apiClient = apiClient
        self.jsonDecoder = jsonDecoder
    }
}

extension GenericTableViewController: TabBarDelegateInjection {
    func setDelegate(_ delegate: TabBarControllerDelegate) {
        self.delegate = delegate
    }
}
