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

    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    init(_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) {
        self.data =  data
        self.response = response
        self.error = error
    }

}

extension ObservableType where E: HTTPResponse {

    /**
     Filters an HTTPResponse observable depending on it's status code.
     - Throws: NetworkingError.emptyResponse if the response is empty.
     - Throws: NetworkingError.badStatusCode(statusCode: Int) if the status code is not in 200...299 range.
     - Returns: An observable of HTTPResponse with only successful responses.
     */
    func filterSuccesfulStatusCodes() -> Observable<E> {
        return self.filter { httpResponse in
            guard let response = httpResponse.response else {
                throw NetworkingError.emptyResponse
            }
            guard 200 ... 299 ~= response.statusCode else {
                throw NetworkingError.badStatusCode(statusCode: response.statusCode)
            }
            return true
        }
    }

    /**
     Maps a HTTPResponse.data to it's proper model type using a JSONDecoder.
     - Throws: NetworkingError.server(message: String) if there was an error in the HTTPResponse.
     - Throws: NetworkingError.emptyData if the data is empty.
     - Returns: An observable of the model type.
     */
    func mapModel<Value: Decodable>(_ type: Value.Type, _ decoder: JSONDecoder) -> Observable<Value> {
        return self.map { httpResponse in
            if httpResponse.error != nil {
                throw NetworkingError.server(message: httpResponse.error.debugDescription)
            }
            guard let data = httpResponse.data else {
                throw NetworkingError.emptyData
            }
            return try decoder.decode(type.self, from: data)
        }
    }

}
