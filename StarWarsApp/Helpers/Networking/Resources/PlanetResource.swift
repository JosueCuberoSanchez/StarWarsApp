//
//  PlanetAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct PlanetResource: Request {

    typealias Value = PlanetResponse

    init(_ path: String) {
        self.path = path
    }

    var path: String
    var index: Int?
    var parameters: [String: String]?
    var method: Method = .GET
    var body: [String: Any]?

}
