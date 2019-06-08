//
//  SpeciesAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct SpeciesResource: Request {

    typealias Value = SpeciesResponse

    init(_ index: Int) {
        self.index = index
    }

    var path = "species/"
    var index: Int?
    var parameters: [String: String]? {
        guard let index = index else {
            return nil
        }
        return ["page": String(index)]
    }
    var method: Method = .GET
    var body: [String: Any]?

}
