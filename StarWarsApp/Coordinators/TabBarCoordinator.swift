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
    let previousViewController: LoginViewController

    var tabBarViewController: TabBarViewController!

    weak var delegate: TabBarCoordinatorDelegate?

    let apiClient = APIClient(baseURL: "https://swapi.co/api/")
    let jsonDecoder: JSONDecoder

    init(from previousViewController: LoginViewController, jsonDecoder: JSONDecoder) {
        self.previousViewController = previousViewController
        self.jsonDecoder = jsonDecoder
    }

    func start() {
        showTabBarController()
    }

    fileprivate func showTabBarController() {
        if let tabBarViewController =
            previousViewController.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController")
                as? TabBarViewController {

            tabBarViewController.customDelegate = self
            tabBarViewController.setDependencies(apiClient: apiClient,
                                                 jsonDecoder: jsonDecoder)
            previousViewController.present(tabBarViewController, animated: false)

        }
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
