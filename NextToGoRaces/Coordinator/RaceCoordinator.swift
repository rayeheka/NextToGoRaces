//
//  RaceCoordinator.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

class MainCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]?
    var navigationController: UINavigationController
    
    init(childCoordinators: [CoordinatorProtocol]? = nil, navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
    }
}

