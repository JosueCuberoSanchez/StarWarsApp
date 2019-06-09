//
//  TabBarView.swift
//  StarWarsApp
//
//  Created by Josue on 1/24/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarControllerDelegate: class {
    func didTapOnPersonRow(of person: Person, using navigationController: UINavigationController)
    func didTapOnStarshipRow(of starship: Starship, using navigationController: UINavigationController)
    func didTapOnSpecieRow(of specie: Specie, using navigationController: UINavigationController)
}

class TabBarViewController: UITabBarController {
    weak var customDelegate: TabBarControllerDelegate!
}

extension TabBarViewController: DependenciesInjection {
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder) {
        for child in viewControllers ?? [] {
            for childNav in child.children {

                // Inject delegate
                if let viewController = childNav as? TabBarDelegateInjection {
                    viewController.setDelegate(customDelegate)
                }

                // Inject dependencies
                if let viewController = childNav as? DependenciesInjection {
                    viewController.setDependencies(apiClient: apiClient, jsonDecoder: jsonDecoder)
                }
            }
        }
    }
}
