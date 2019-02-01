//
//  Response.swift
//  StarWarsApp
//
//  Created by Josue on 1/16/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

enum Response<Value> {
    case success(Value)
    case failure(Error)
}

protocol ResponseProtocol {
    associatedtype Value
    func unwrapSuccess() throws -> Value
    func unwrapError() -> Error?
    var isSuccessful: Bool { get }
}

extension Response: ResponseProtocol {

    /**
     Gets the data from the Response, if it's an error throw it.
     */
    func unwrapSuccess() throws -> Value {
        switch self {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }

    /**
     Gets the error from the Response, if it wasn't an error return an optional.
     */
    func unwrapError() -> Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

    /**
     If there is data on the response, return true, else false.
     */
    var isSuccessful: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

}

extension ObservableType where E: ResponseProtocol {

    /**
     Gets the successful data from the response.
     */
    func mapSuccess() -> Observable<E.Value> {
        return filter { $0.isSuccessful }.map { try $0.unwrapSuccess() }
    }

    /**
     Gets the error from the response.
     */
    func mapError() -> Observable<Error?> {
        return filter { !$0.isSuccessful }.map { $0.unwrapError() }
    }

}

extension ObservableType where E: Decodable {

    /**
     Wraps a model type into Response.success.
     - Returns: An observable of <Response<E>>, where E is the model.
     */
    func wrapSuccess() -> Observable<Response<E>> {
        return map { Response.success($0) }
    }

}
