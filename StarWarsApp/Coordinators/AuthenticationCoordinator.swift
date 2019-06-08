//
//  AuthenticationCoordinator.swift
//  StarWarsApp
//
//  Created by Josue on 1/30/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func coordinatorDidAuthenticate(coordinator: AuthenticationCoordinator)
}

final class AuthenticationCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()

    let window: UIWindow

    weak var delegate: AuthenticationCoordinatorDelegate?

    let apiClient = APIClient(baseURL: "http://localhost:7777/api/")
    let jsonDecoder: JSONDecoder

    init(from window: UIWindow, jsonDecoder: JSONDecoder) {
        self.window = window
        self.jsonDecoder = jsonDecoder
    }

    func start() {
        showLoginViewController()
    }

    func showLoginViewController() {
        if let loginViewController = window.rootViewController as? LoginViewController {
            loginViewController.setDependencies(apiClient: apiClient, jsonDecoder: jsonDecoder)
            loginViewController.delegate = self
        }
        // In a full programmatic way, I should present or show the VC here.
        // Also, if I would have to instantiate it here, I could inject it's VM.
    }

}

extension AuthenticationCoordinator: LoginViewControllerDelegate {

    func didSuccessfullyLogin() {
        delegate?.coordinatorDidAuthenticate(coordinator: self)
    }

}
