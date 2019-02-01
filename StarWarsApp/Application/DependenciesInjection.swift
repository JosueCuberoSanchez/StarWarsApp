//
//  APIClientInyectionProtocol.swift
//  StarWarsApp
//
//  Created by Josue on 1/17/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import UIKit

protocol DependenciesInjection {
    func setDependencies(apiClient: APIClient, jsonDecoder: JSONDecoder)
}

protocol TabBarDelegateInjection {
    func setDelegate(_ delegate: TabBarControllerDelegate)
}
