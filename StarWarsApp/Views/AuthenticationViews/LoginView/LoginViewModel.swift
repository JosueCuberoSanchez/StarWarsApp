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

    // Outputs
    var loginSuccess: Driver<LoginResponse>
    var loginFailure: Driver<Error>

    init(request: @escaping (_ body: [String: Any]) -> Driver<Response<LoginResponse>>) {
        let email = self.email.asDriver(onErrorDriveWith: Driver.empty())
        let password = self.password.asDriver(onErrorDriveWith: Driver.empty())
        let credentialsBody = Driver.combineLatest(email, password) { ["email": $0, "password": $1] }

        let request = loginTrigger.asDriver(onErrorDriveWith: Driver.empty())
            .withLatestFrom(credentialsBody)
            .flatMapLatest { request($0) }

        loginSuccess = request.unwrapSuccess()
        loginFailure = request.unwrapError()
    }

}
