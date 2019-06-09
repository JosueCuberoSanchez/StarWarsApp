//
//  PeopleAPI.swift
//  StarWarsApp
//
//  Created by Josue on 1/7/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum Method: String {
    case GET
    case POST
}

protocol Resource {

    var path: String { get }
    var index: Int? { get }
    var method: Method { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }

}

protocol Request: Resource {
    associatedtype Value // Model type

    func execute(with apiClient: APIClient, using decoder: JSONDecoder) -> Driver<Response<Value>>
}

extension Request where Value: Decodable {
    func execute(with apiClient: APIClient, using decoder: JSONDecoder) -> Driver<Response<Value>> {
        return apiClient.execute(self)
            .filterSuccesfulStatusCodes()
            .mapModel(Value.self, decoder)
            .wrapSuccess()
    }
}
