//
//  SpecieViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SpecieViewModel {
    // Inputs
    private var specieDriver: Driver<Specie>

    // Outputs
    var specieName: Driver<String>
    var specieClassification: Driver<String>
    var specieAverageHeight: Driver<String>
    var specieLanguage: Driver<String>
    var specieHomeworld: Driver<String>

    init(request: @escaping (_ planetPath: String) -> Driver<Response<PlanetResponse>>, specie: Specie) {
        specieDriver = Driver.just(specie)

        let request = specieDriver
            .map { $0.homeworld?.resourcePath }
            .filterNil()
            .flatMapLatest { request($0) }
        let planetResponse = request.unwrapSuccess()

        specieName = specieDriver.map { $0.name }
        specieClassification = specieDriver.map { $0.classification }
        specieAverageHeight = specieDriver.map { $0.averageHeight }
        specieLanguage = specieDriver.map { $0.language }
        specieHomeworld = planetResponse.map { $0.name }.asDriver(onErrorDriveWith: Driver.empty())
    }
}
