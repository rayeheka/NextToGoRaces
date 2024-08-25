//
//  CoordinatorProtocol.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol]? { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
