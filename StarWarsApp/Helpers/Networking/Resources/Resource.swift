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

    /**
     Executes a resource.
     - Returns: A driver of <Response<Value>> where Value is the proper response model.
     */
    func execute(with apiClient: APIClient, using decoder: JSONDecoder) -> Driver<Response<Value>> {
        return
            apiClient.execute(self) // Observable<HTTPResponse>
                .filterSuccesfulStatusCodes() // Observable<HTTPResponse> where 200<=SC>=299
                .mapModel(Value.self, decoder) // Observable<Value>
                .wrapSuccess() // Observable<Response<Value>>
                .asDriver(onErrorRecover: { Driver<Response<Value>>.just(Response.failure($0)) })
    }

}
