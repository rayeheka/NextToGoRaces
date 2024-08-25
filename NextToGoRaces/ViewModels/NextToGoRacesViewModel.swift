//
//  NextToGoRacesViewModel.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import Combine

class NextToGoRacesViewModel: ObservableObject {
    @Published var allRaces: [RaceSummaryViewModel] = []
    
    private var selectedCategories: Set<RaceCategory> = Set(RaceCategory.allCases)
    
    private var racesManager: RacesManagerProtocol
    
    init(racesManager: RacesManagerProtocol) {
        self.racesManager = racesManager
    }
    
    func getRaces() async {
        let races = await racesManager.fetchRaces()
        let convertedRaces = convertRaceSummariesToViewModel(races)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.allRaces = convertedRaces
        }
    }
    
    func convertRaceSummariesToViewModel(_ races: [RaceSummary]) -> [RaceSummaryViewModel] {
        return races.map { RaceSummaryViewModel(raceSummary: $0) }
    }
}

