//
//  UICollectionView+Extension.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(type, forCellWithReuseIdentifier: "\(T.self)")
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReusableIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(T.defaultReusableIdentifier)")
        }
        return cell
    }
}
