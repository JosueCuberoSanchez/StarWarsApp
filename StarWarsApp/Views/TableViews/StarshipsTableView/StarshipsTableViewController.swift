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

class StarshipsTableViewController: GenericTableViewController<StarshipsTableViewModel> {

    override func viewDidLoad() {
        viewModel = StarshipsTableViewModel(
            request: { StarshipsResource($0).execute(with: self.apiClient, using: self.jsonDecoder) }
        )

        super.viewDidLoad()

        tableView.rx.modelSelected(Starship.self).asDriver()
            .drive(onNext: { [ weak self ] starship in
                if let navigationController = self?.navigationController {
                    self?.delegate?.didTapOnStarshipRow(of: starship, using: navigationController)
                }
            })
            .disposed(by: disposeBag)
    }

    override func setCellLabelContents(_ cell: TabListTableViewCell, _ model: Starship) {
        cell.nameLabel.text = model.name
        cell.detailLabel.text = model.manufacturer
    }
}
