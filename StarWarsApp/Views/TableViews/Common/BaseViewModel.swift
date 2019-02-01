//
//  PeopleViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModel {

    associatedtype Model

    var pagination: BehaviorRelay<Int> { get }
    var activityIndicator: ActivityIndicator { get }
    var itemsRelay: BehaviorRelay<[Model]> { get }
    var nextPageTrigger: PublishRelay<Void> { get }
    var filterSource: BehaviorRelay<String> { get }
    var modelList: Driver<[Model]> { get }
    var maxPage: Int { get }

}
