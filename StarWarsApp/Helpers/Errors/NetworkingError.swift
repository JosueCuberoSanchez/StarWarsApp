//
//  NetworkingError.swift
//  StarWarsApp
//
//  Created by Josue on 1/28/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case invalidRequest
    case emptyResponse
    case emptyData
    case server(message: String)
    case badStatusCode(statusCode: Int)
}
