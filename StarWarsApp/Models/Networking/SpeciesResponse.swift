//
//  SpeciesResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct SpeciesResponse: Codable, PaginatedAPIResponse {

    var count: Int
    var next: String?
    var previous: String?
    let species: [Specie]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case species = "results"
    }

}
