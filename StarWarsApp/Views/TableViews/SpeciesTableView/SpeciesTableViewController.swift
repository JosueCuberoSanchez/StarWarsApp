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

class SpeciesTableViewController: GenericTableViewController<SpeciesTableViewModel> {

    override func viewDidLoad() {
        viewModel =
            SpeciesTableViewModel(
                request: { [weak self] in
                    guard let sself = self else { return Driver.empty() }
                    return SpeciesResource($0).execute(with: sself.apiClient, using: sself.jsonDecoder)
                }
            )

        super.viewDidLoad()

        tableView.rx.modelSelected(Specie.self).asDriver()
            .drive(onNext: { [ weak self ] specie in
                if let navigationController = self?.navigationController {
                    self?.delegate?.didTapOnSpecieRow(of: specie, using: navigationController)
                }
            })
            .disposed(by: disposeBag)
    }

    override func setCellLabelContents(_ cell: TabListTableViewCell, _ model: Specie) {
        cell.nameLabel.text = model.name
        cell.detailLabel.text = model.classification
    }

}
