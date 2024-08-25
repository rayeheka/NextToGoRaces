//
//  RaceCategoryEnum.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import UIKit

enum RaceCategory: String, CaseIterable {
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    
    var name: String {
        switch self {
        case .greyhound:
            return "Greyhound racing"
        case .harness:
            return "Harness racing"
        case .horse:
            return "Horse racing"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .greyhound:
            return UIImage(named: Gallery.greyhoundRacing.rawValue)
        case .harness:
            return UIImage(named: Gallery.harnessRacing.rawValue)
        case .horse:
            return UIImage(named: Gallery.horseRacing.rawValue)
        }
    }
}
