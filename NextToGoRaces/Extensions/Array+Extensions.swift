//
//  Array+Extensions.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

extension Array where Element: RaceSummaryViewModel {
    ///This funtion applies filter on arrays which elements are of type ```RaceSummaryViewMode```
    ///
    /// - Parameter selectedCategories: A set of RaceCategories that the array should be sorted base on.
    /// - Returns: A filtered array
    func applyFilter(basedOn selectedCategories: Set<RaceCategory>) -> Self {
        return self.filter { selectedCategories.contains($0.category) }
    }
}
