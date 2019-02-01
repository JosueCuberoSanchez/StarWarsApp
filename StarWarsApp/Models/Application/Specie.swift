//
//  Specie.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct Specie: Codable {

    let averageHeight: String
    let language: String
    let homeworld: String?
    let name: String
    let classification: String

    enum CodingKeys: String, CodingKey {
        case averageHeight = "average_height"
        case language = "language"
        case homeworld = "homeworld"
        case name = "name"
        case classification = "classification"
    }

}

extension Specie: Equatable {
    static func == (specie1: Specie, specie2: Specie) -> Bool {
        return
            specie1.averageHeight == specie2.averageHeight && specie1.language == specie2.language &&
            specie1.homeworld == specie2.homeworld && specie1.name == specie2.name &&
            specie1.classification == specie2.classification
    }
}
