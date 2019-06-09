//
//  PersonViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class PersonViewModel {
    // Inputs
    private var personDriver: Driver<Person>

    // Outputs
    var personName: Driver<String>
    var personHeight: Driver<String>
    var personGender: Driver<Person.Gender>
    var personHomeworld: Driver<String>

    init(request: @escaping (_ planetPath: String) -> Driver<Response<PlanetResponse>>, person: Person) {
        personDriver = Driver.just(person)

        let request = personDriver
            .map { $0.homeworld.resourcePath }
            .filterNil()
            .flatMapLatest { request($0) }
        let planetResponse = request.unwrapSuccess()

        personName = personDriver.map { $0.name }
        personGender = personDriver.map { $0.gender }
        personHeight = personDriver.map { $0.height }
        personHomeworld = planetResponse.map { $0.name }.asDriver(onErrorDriveWith: Driver.empty())
    }
}
