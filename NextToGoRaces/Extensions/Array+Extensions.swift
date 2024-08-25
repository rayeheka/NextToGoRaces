//
//  Array+Extensions.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

extension Array where Element: RaceSummaryViewModel {
    func applyFilter(basedOn selectedCategories: Set<RaceCategory>) -> Self {
        return self.filter { selectedCategories.contains($0.category) }
    }
}
