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

class StarshipViewModel {

    // Inputs
    private var starshipDriver: Driver<Starship>

    // Outputs
    var starshipName: Driver<String>
    var starshipManufacturer: Driver<String>
    var starshipLength: Driver<String>
    var starshipPassengers: Driver<String>
    var starshipClass: Driver<String>

    init(starship: Starship) {

        starshipDriver = Driver.of(starship)

        starshipName = starshipDriver.map { $0.name }
        starshipManufacturer = starshipDriver.map { $0.manufacturer }
        starshipLength = starshipDriver.map { $0.length }
        starshipPassengers = starshipDriver.map { $0.passengers }
        starshipClass = starshipDriver.map { $0.starshipClass }

    }

}
