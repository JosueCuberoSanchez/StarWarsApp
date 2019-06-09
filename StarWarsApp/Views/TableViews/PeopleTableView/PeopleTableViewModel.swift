//
//  PersonTestViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/29/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PeopleTableViewModel: BaseViewModel {

    typealias Model = Person

    let pagination = BehaviorRelay<Int>(value: 1)
    let activityIndicator = ActivityIndicator()
    let itemsRelay = BehaviorRelay<[Model]>(value: [])
    let nextPageTrigger = PublishRelay<Void>()
    let filterSource = BehaviorRelay<String>(value: "")
    let modelList: SharedSequence<DriverSharingStrategy, [Model]>
    let maxPage = 10

    private let disposeBag = DisposeBag()

    init(request: @escaping (_ page: Int) -> Driver<Response<PeopleResponse>>) {

        modelList = Driver.combineLatest(itemsRelay.asDriver(), filterSource.asDriver()) { data, filter in
            data.filter {
                guard filter != "" else { return true }
                return $0.name.lowercased().contains(filter.lowercased())
            }
        }

        let activityIndicator = self.activityIndicator
        let request = pagination.asDriver()
            .flatMapLatest { request($0).trackActivity(activityIndicator).asDriver(onErrorDriveWith: Driver.empty()) }
        let peopleResponse = request.unwrapSuccess()

        peopleResponse.map { $0.people }
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
