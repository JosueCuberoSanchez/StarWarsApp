//
//  StarshipsResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct StarshipsResponse: Codable, PaginatedAPIResponse {

    var count: Int
    var next: String?
    var previous: String?
    let starships: [Starship]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case starships = "results"
    }

}
