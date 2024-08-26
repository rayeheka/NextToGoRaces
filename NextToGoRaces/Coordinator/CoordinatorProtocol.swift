//
//  CoordinatorProtocol.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

/// The `CoordinatorProtocol` protocol defines the responsibilities of a coordinator,
/// which is responsible for controlling the flow of the application
/// and managing the navigation between view controllers.
protocol CoordinatorProtocol: AnyObject {
    /// Child coordinators are often managed to help break down the navigation flow
    /// into smaller, reusable units.
    var childCoordinators: [CoordinatorProtocol]? { get set }
    
    /// Navigation Controller is the base navigation of the coordinator which handles
    /// view controllers to be shown or popped.
    var navigationController: UINavigationController { get set }
    
    /// Starts the coordinator and performs the initial setup and presentation
    /// of view controllers. This method is the entry point for the coordinator's
    /// navigation flow.
    func start()
}
