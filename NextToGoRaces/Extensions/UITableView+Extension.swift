//
//  UITableView+Extension.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: "\(T.self)")
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReusableIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(T.defaultReusableIdentifier)")
        }
        return cell
    }
}
