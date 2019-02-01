//
//  LoginResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {

    var points: Int
    var email: String
    var firstName: String
    var lastName: String
    var username: String
    var phone: String
    var facebook: String
    var twitter: String
    var instagram: String
    var image: String
    var userId: String

}
