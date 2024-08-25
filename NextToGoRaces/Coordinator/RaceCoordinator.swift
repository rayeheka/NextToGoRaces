//
//  RaceCoordinator.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

class RaceCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]?
    var navigationController: UINavigationController
    
    init(childCoordinators: [CoordinatorProtocol]? = nil, navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = createNextToGoRacesViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func createNextToGoRacesViewController() -> NextToGoRacesViewController {
        let urlSessionService = URLSessionService()
        let racesService = RacesService(networkService: urlSessionService)
        let numberOfRacesToFetch = 10
        let numberOfRacesToShow = 5
        let racesManager = RacesManager(racesService: racesService, numberOfRacesToFetch: numberOfRacesToFetch, numberOfRacesToShow: numberOfRacesToShow)
        let viewModel = NextToGoRacesViewModel(racesManager: racesManager)
        return NextToGoRacesViewController(nextToGoRacesViewModel: viewModel)
    }
}

