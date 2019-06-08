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

    var pagination = BehaviorRelay<Int>(value: 1)
    var activityIndicator = ActivityIndicator()
    var itemsRelay = BehaviorRelay<[Model]>(value: [])
    var nextPageTrigger = PublishRelay<Void>()
    var filterSource = BehaviorRelay<String>(value: "")
    var modelList: SharedSequence<DriverSharingStrategy, [Model]>
    var maxPage = 10

    private let disposeBag = DisposeBag()

    init(request: @escaping (_ page: Int) -> Driver<Response<PeopleResponse>>) {

        modelList = Driver.combineLatest(itemsRelay.asDriver(), filterSource.asDriver()) { data, filter in
            data.filter { person in
                guard filter != "" else {
                    return true
                }
                return person.name.lowercased().contains(filter.lowercased())
            }
        }

        let activityIndicator = self.activityIndicator
        
        /* cuando este request comienza es por que el trigger lo dejo pasar por estar en F, 
         entonces el track cambia el AI de F a V, para no dejar pasar a nadie mas.*/
        let sharedRequest = pagination
            .flatMap { request($0).trackActivity(activityIndicator) }.share()
        /* cuando este request termina, el track activity se encargar de hacerle decrement 
         al activity indicator, pasando de V a F*/
        let peopleResponse = sharedRequest.mapSuccess()

        peopleResponse.map { $0.people } // map people array to items relay
            .withLatestFrom(itemsRelay) { $1 + $0 }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(itemsRelay)
            .disposed(by: disposeBag)

        /* trigger for next page loads, triggers the first time because it has a value already.
         next triggers are made by the view controller, and pagination changes (+1) making 
         the shared request trigger the next page load.*/
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
