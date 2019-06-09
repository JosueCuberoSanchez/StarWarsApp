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

    private var apiClient: APIClient!
    private var jsonDecoder: JSONDecoder!
    private var loginViewModel: LoginViewModel!

    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()

    private let disposeBag = DisposeBag()

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

    private func setupBindings() {
        emailTextField.rx.text.orEmpty
            .asDriver()
            .drive(loginViewModel.email)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .asDriver()
            .drive(loginViewModel.password)
            .disposed(by: disposeBag)

        loginButton.rx.tap.asDriver()
            .drive(loginViewModel.loginTrigger)
            .disposed(by: disposeBag)

        loginViewModel.loginFailure
            .drive(onNext: { [weak self] _ in self?.setErrorBordersForInputFields() })
            .disposed(by: disposeBag)

        loginViewModel.loginSuccess
            .drive(onNext: { [weak self] _ in self?.delegate?.didSuccessfullyLogin() })
            .disposed(by: disposeBag)
    }

}

extension LoginViewController: DependenciesInjection {
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder) {
        self.apiClient = apiClient
        self.jsonDecoder = jsonDecoder
    }
}
