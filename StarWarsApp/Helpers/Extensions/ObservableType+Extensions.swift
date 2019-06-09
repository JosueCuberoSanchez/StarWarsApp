//
//  ObservableType+Extensions.swift
//  StarWarsApp
//
//  Created by Josue on 6/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where E: HTTPResponse {
    func filterSuccesfulStatusCodes() -> Observable<E> {
        return self.filter {
            guard let response = $0.response else {
                throw NetworkingError.emptyResponse
            }
            guard 200 ... 299 ~= response.statusCode else {
                throw NetworkingError.badStatusCode(statusCode: response.statusCode)
            }
            return true
        }
    }

    func mapModel<Value: Decodable>(_ type: Value.Type, _ decoder: JSONDecoder) -> Driver<Value> {
        return self.map {
            if $0.error != nil {
                throw NetworkingError.server(message: $0.error.debugDescription)
            }
            guard let data = $0.data else {
                throw NetworkingError.emptyData
            }
            return try decoder.decode(type.self, from: data)
        }
        .asDriver(onErrorDriveWith: Driver.empty())
    }
}
