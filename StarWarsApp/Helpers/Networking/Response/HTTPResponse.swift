//
//  HTTPResponse.swift
//  StarWarsApp
//
//  Created by Josue on 1/30/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HTTPResponse { // wrapper for the server response
    let data: Data?
    let response: HTTPURLResponse?
    let error: Error?

    init(_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) {
        self.data =  data
        self.response = response
        self.error = error
    }
}
