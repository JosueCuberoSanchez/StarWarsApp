//
//  SpeciesViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SpeciesTableViewModel: BaseViewModel {

    typealias Model = Specie

    let pagination = BehaviorRelay<Int>(value: 1)
    let activityIndicator = ActivityIndicator()
    let itemsRelay = BehaviorRelay<[Model]>(value: [])
    let nextPageTrigger = PublishRelay<Void>()
    let filterSource = BehaviorRelay<String>(value: "")
    let modelList: SharedSequence<DriverSharingStrategy, [Model]>
    let maxPage = 5

    private let disposeBag = DisposeBag()

    init(request: @escaping (_ page: Int) -> Driver<Response<SpeciesResponse>>) {

        modelList = Driver.combineLatest(itemsRelay.asDriver(), filterSource.asDriver()) { data, filter in
            data.filter { specie in
                guard filter != "" else {
                    return true
                }
                return specie.name.lowercased().contains(filter.lowercased())
            }
        }

        let activityIndicator = self.activityIndicator
        let request = pagination.asDriver()
            .flatMapLatest {
                request($0).trackActivity(activityIndicator).asDriver(onErrorDriveWith: Driver.empty())
            }
        let specieResponse = request.unwrapSuccess()

        specieResponse.map { $0.species }
            .withLatestFrom(itemsRelay.asDriver()) { $1 + $0 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemsRelay)
            .disposed(by: disposeBag)

        let maxPage = self.maxPage
        nextPageTrigger
            .withLatestFrom(activityIndicator)
            .filter { !$0 }
            .withLatestFrom(pagination) { $1 + 1 }
            .filter { $0 < maxPage }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(pagination)
            .disposed(by: disposeBag)

    }

}
