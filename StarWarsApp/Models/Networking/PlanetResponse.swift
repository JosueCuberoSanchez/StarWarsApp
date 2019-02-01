//
//  PlanetResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/10/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PlanetResponse: Codable {

    let population: String
    let gravity: String
    let diameter: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let name: String
    let climate: String
    let terrain: String
    let surfaceWater: String
    let residents: [String]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case population = "population"
        case residents = "residents"
    }

}
