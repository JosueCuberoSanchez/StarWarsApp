//
//  PeopleTableTestViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/29/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PeopleTableViewController: GenericTableViewController<PeopleTableViewModel> {

    override func viewDidLoad() {
        viewModel =
            PeopleTableViewModel(
                request: { [weak self] in
                    guard let sself = self else { return Driver.empty() }
                    return PeopleResource($0).execute(with: sself.apiClient, using: sself.jsonDecoder)
                }
            )

        super.viewDidLoad()

        tableView.rx.modelSelected(Person.self).asDriver()
            .drive(onNext: { [ weak self ] person in
                if let navigationController = self?.navigationController {
                    self?.delegate?.didTapOnPersonRow(of: person, using: navigationController)
                }
            })
            .disposed(by: disposeBag)
    }

    override func setCellLabelContents(_ cell: TabListTableViewCell, _ model: Person) {
        cell.nameLabel.text = model.name
        cell.detailLabel.text = model.gender.rawValue
    }

}
