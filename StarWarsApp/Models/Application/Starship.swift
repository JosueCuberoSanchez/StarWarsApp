//
//  Starship.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct Starship: Codable {

    let passengers: String
    let length: String
    let name: String
    let manufacturer: String
    let starshipClass: String

    enum CodingKeys: String, CodingKey {
        case passengers = "passengers"
        case length = "length"
        case name = "name"
        case manufacturer = "manufacturer"
        case starshipClass = "starship_class"
    }

}

extension Starship: Equatable {
    static func == (starship1: Starship, starship2: Starship) -> Bool {
        return
            starship1.passengers == starship2.passengers && starship1.length == starship2.length &&
            starship1.name == starship2.name && starship1.manufacturer == starship2.manufacturer &&
            starship1.starshipClass == starship2.starshipClass
    }
}
