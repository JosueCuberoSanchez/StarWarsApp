//
//  Reactive+ScrollViewBottomReached.swift
//  StarWarsApp
//
//  Created by Josue on 1/18/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// Taken from: https://github.com/tryswift/RxPagination/blob/master/Pagination/UIScrollView%2BRx.swift
// Detects when user has reached the bottom of the table view's scroll view
extension Reactive where Base: UIScrollView {

    var reachedBottom: ControlEvent<Void> {
        let observable = contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else {
                    return Observable.empty()
                }

                let visibleHeight = scrollView.frame.height -
                    scrollView.contentInset.top - scrollView.contentInset.bottom
                let yAxis = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)

                return yAxis > threshold ? Observable.just(()) : Observable.empty()
        }

        return ControlEvent(events: observable)
    }

}
