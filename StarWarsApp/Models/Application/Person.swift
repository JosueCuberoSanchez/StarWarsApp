//
//  Person.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct Person: Codable {

    enum Gender: String, Codable {
        case male = "male"
        case female = "female"
        case notApplicable = "n/a"
        case hermaphrodite = "hermaphrodite"
        case none = "none"
    }

    let height: String
    let homeworld: String
    let name: String
    let gender: Gender

}

extension Person: Equatable {
    static func == (person1: Person, person2: Person) -> Bool {
        return
            person1.gender == person2.gender && person1.height == person2.height &&
            person1.homeworld == person2.homeworld && person1.name == person2.name
    }
}
