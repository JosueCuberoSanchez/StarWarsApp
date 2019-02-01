//
//  PeopleResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PeopleResponse: Codable, PaginatedAPIResponse {

    var count: Int
    var next: String?
    var previous: String?
    let people: [Person]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case people = "results"
    }

}
