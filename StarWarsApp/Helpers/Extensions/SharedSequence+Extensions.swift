//
//  SharedSequence+Extensions.swift
//  StarWarsApp
//
//  Created by Josue on 6/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    public func drive(_ relay: RxCocoa.PublishRelay<Self.E>) -> Disposable {
        return self.drive(onNext: { relay.accept($0) })
    }
}

extension SharedSequence where S == DriverSharingStrategy, Element: ResponseProtocol {
    
    func unwrapSuccess() -> SharedSequence<SharingStrategy, E.Value> {
        return self.filter { $0.isSuccessful }
            // swiftlint:disable:next force_try
            .map { try! $0.unwrapSuccess() }
    }
    
    func unwrapError() -> SharedSequence<SharingStrategy, E.Error> {
        return self.filter { !$0.isSuccessful }
            .map { $0.unwrapError() }
            .filterNil()
    }
}

extension SharedSequenceConvertibleType where E: Decodable {
    func wrapSuccess() -> SharedSequence<SharingStrategy, Response<E>> {
        return map { Response.success($0) }
    }
}
