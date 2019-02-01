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

        // Asign personDriver
        personDriver = Driver.of(person)

        // Map homeworld driver
        // Observable<Response<PlanetResponse>>
        let sharedRequest = personDriver.asObservable().flatMap { request($0.homeworld.resourcePath) }.share()
        let planetResponse = sharedRequest.mapSuccess()

        // Map each Driver to the corresponding person attribute
        personName = personDriver.map { $0.name }
        personGender = personDriver.map { $0.gender }
        personHeight = personDriver.map { $0.height }
        personHomeworld = planetResponse.map { $0.name }.asDriver(onErrorDriveWith: Driver.empty())

    }

}
