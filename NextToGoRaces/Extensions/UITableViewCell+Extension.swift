//
//  UITableViewCell+Extension.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var defaultReusableIdentifier: String {
        String(describing: "\(self.self)")
    }
}

