//
//  LoginViewController.swift
//  StarWarsApp
//
//  Created by Josue on 1/25/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginViewControllerDelegate: class {
    func didSuccessfullyLogin()
}

class LoginViewController: UIViewController {

    var apiClient: APIClient!
    var jsonDecoder: JSONDecoder!
    var loginViewModel: LoginViewModel!

    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()

    let disposeBag = DisposeBag()

    weak var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel(
            request: { [weak self] in
                guard let sself = self else { return Driver.empty() }
                return LoginResource($0).execute(with: sself.apiClient, using: sself.jsonDecoder)
            }
        )
        setupBindings()
    }

    /**
     Binds the inputs, button and login response.
     */
    private func setupBindings() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: loginViewModel.email)
//            .subscribe(onNext: { [weak self] in
//                self?.loginViewModel.email.accept($0)
//            })
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.password.accept($0)
            })
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.loginViewModel.loginTrigger.accept(())
            })
            .disposed(by: disposeBag)

        loginViewModel.loginFailure
            .drive(onNext: { [weak self] error in
                print(error.localizedDescription)
                self?.setErrorBordersForInputFields()
            })
            .disposed(by: disposeBag)

        loginViewModel.loginSuccess
            .drive(onNext: { [weak self] user in
                print("Welcome \(user.firstName) \(user.lastName)")
                self?.delegate?.didSuccessfullyLogin()
            })
            .disposed(by: disposeBag)
    }

}

extension LoginViewController: DependenciesInjection {
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder) {
        self.apiClient = apiClient
        self.jsonDecoder = jsonDecoder
    }
}
