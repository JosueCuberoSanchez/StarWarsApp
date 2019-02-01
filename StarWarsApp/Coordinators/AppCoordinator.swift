//
//  AppCoordinator.swift
//  StarWarsApp
//
//  Created by Josue on 1/30/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

// All coordinators will have this properties
protocol Coordinator: class { // Class is needed to filter with !== 
    var childCoordinators: [Coordinator] { get set }
    func start()
    func removeCoordinator(coordinator: Coordinator)
}

// App coordinator is used at app start.
final class AppCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()

    let viewController: LoginViewController
    let jsonDecoder: JSONDecoder

    init(viewController: LoginViewController, jsonDecoder: JSONDecoder) {
        self.viewController = viewController
        self.jsonDecoder = jsonDecoder
    }

    func start() {
        /* If app is implementing sessions, it should check if the user is logged in
         to show tabbar instead of authentication view.*/
        showAuthentication()
    }

    // All the showSomething funcs in a given coordinator should be children of the actual coordinator.

    fileprivate func showAuthentication() {
        let authenticationCoordinator = AuthenticationCoordinator(from: viewController, jsonDecoder: jsonDecoder)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        childCoordinators.append(authenticationCoordinator)
    }

    fileprivate func showTabBar() {
        let tabBarCoordinator = TabBarCoordinator(from: viewController, jsonDecoder: jsonDecoder)
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }

}

extension Coordinator {

    // All coordinators should have a remove coordinator func, but it should have the same logic.
    func removeCoordinator(coordinator: Coordinator) {
        let arr = childCoordinators.filter {$0 !== coordinator}
        childCoordinators = arr
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {

    func coordinatorDidAuthenticate(coordinator: AuthenticationCoordinator) {
        removeCoordinator(coordinator: coordinator)
        showTabBar()
    }

}
