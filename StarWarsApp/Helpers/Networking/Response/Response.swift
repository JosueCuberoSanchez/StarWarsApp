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
    associatedtype Error
    func unwrapSuccess() throws -> Value
    func unwrapError() -> Error?
    var isSuccessful: Bool { get }
}

extension Response: ResponseProtocol {
    func unwrapSuccess() throws -> Value {
        switch self {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }

    func unwrapError() -> Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

    var isSuccessful: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}
