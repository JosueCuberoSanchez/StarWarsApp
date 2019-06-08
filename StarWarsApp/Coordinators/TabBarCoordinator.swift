//
//  TabBarCoordinator.swift
//  StarWarsApp
//
//  Created by Josue on 1/30/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarCoordinatorDelegate: class {
    func coordinatorDidChoseRow(coordinator: TabBarCoordinator)
}

final class TabBarCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()

    let window: UIWindow

    weak var delegate: TabBarCoordinatorDelegate?

    let apiClient = APIClient(baseURL: "https://swapi.co/api/")
    let jsonDecoder: JSONDecoder

    init(from window: UIWindow, jsonDecoder: JSONDecoder) {
        self.window = window
        self.jsonDecoder = jsonDecoder
    }

    func start() {
        showTabBarController()
    }

    fileprivate func showTabBarController() {
        let tabBarViewController = window.rootViewController?.storyboard?
            .instantiateViewController(withIdentifier: "tabBarViewController") as? TabBarViewController
        tabBarViewController?.customDelegate = self
        tabBarViewController?.setDependencies(apiClient: apiClient, jsonDecoder: jsonDecoder)
        window.rootViewController = tabBarViewController
    }

    fileprivate func showPersonViewController(of person: Person,
                                              using navigationController: UINavigationController) {
        navigationController
            .pushViewController(PersonViewController(person, apiClient), animated: true)
    }

    fileprivate func showStarshipViewController(of starship: Starship,
                                                using navigationController: UINavigationController) {
        navigationController
            .pushViewController(StarshipViewController(starship, apiClient), animated: true)
    }

    fileprivate func showSpecieViewController(of specie: Specie,
                                              using navigationController: UINavigationController) {
        navigationController
            .pushViewController(SpecieViewController(specie, apiClient), animated: true)
    }

}

extension TabBarCoordinator: TabBarControllerDelegate {

    func didTapOnPersonRow(of person: Person,
                           using navigationController: UINavigationController) {
        showPersonViewController(of: person, using: navigationController)
    }

    func didTapOnStarshipRow(of starship: Starship,
                             using navigationController: UINavigationController) {
        showStarshipViewController(of: starship, using: navigationController)
    }

    func didTapOnSpecieRow(of specie: Specie,
                           using navigationController: UINavigationController) {
        showSpecieViewController(of: specie, using: navigationController)
    }

}
