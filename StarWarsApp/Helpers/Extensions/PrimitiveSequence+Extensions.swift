//
//  PrimitiveSequence+Extensions.swift
//  StarWarsApp
//
//  Created by Josue on 6/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

extension PrimitiveSequence where Trait == SingleTrait, Element: OptionalType {
    public func filterNil() -> PrimitiveSequence<Trait, Element.Wrapped> {
        return flatMap { element -> PrimitiveSequence<Trait, Element.Wrapped> in
            guard let value = element.value else {
                return Observable.empty().asSingle()
            }
            return PrimitiveSequence<Trait, Element.Wrapped>.just(value)
        }
    }
}
