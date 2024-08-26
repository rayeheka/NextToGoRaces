//
//  UITableView+Extension.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

extension UITableView {
    
    /// Register cell with class type
    /// - Parameter type: Enter the class name
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: "\(T.self)")
    }
    
    /// Dequeue reusable UITableViewCell using class type.
    ///
    /// - Parameters:
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReusableIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(T.defaultReusableIdentifier)")
        }
        return cell
    }
}
