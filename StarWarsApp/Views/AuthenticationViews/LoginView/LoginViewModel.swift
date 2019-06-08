//
//  LoginViewModel.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {

    // Inputs
    var email = PublishRelay<String>()
    var password = PublishRelay<String>()
    var loginTrigger = PublishRelay<Void>()

    var loginSuccess: Driver<LoginResponse>
    var loginFailure: Driver<Error>

    init(request: @escaping (_ body: [String: Any]) -> Driver<Response<LoginResponse>>) {
        loginSuccess = Driver.empty()
        loginFailure = Driver.empty()

        let credentialsBody =
            Observable.combineLatest(email.asObservable(), password.asObservable()) { (email, password) in
                return ["email": email, "password": password]
            }

        // Simulate the api call
        let sharedRequest = loginTrigger
            .withLatestFrom(credentialsBody)
            .flatMapLatest { request($0) }
            .share()

        let credentialsResponse = sharedRequest.mapSuccess()
        let errorResponse = sharedRequest.mapError()

        loginSuccess = credentialsResponse.map { $0 }.asDriver(onErrorDriveWith: Driver.empty())
        loginFailure = errorResponse.filterNil().asDriver(onErrorDriveWith: Driver.empty())
    }

}
