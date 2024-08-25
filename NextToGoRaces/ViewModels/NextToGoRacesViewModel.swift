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
    
    private var countdownTimer: Timer?
    private let countdownInterval: TimeInterval = 1
    
    init(racesManager: RacesManagerProtocol) {
        self.racesManager = racesManager
    }
    
    func getRaces() async {
        let races = await racesManager.fetchRaces()
        let convertedRaces = convertRaceSummariesToViewModel(races)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.allRaces = convertedRaces
            
            // Schedule countdown updates every second to show smooth seconds changing
            self.countdownTimer = Timer.scheduledTimer(withTimeInterval: self.countdownInterval, repeats: true) { [weak self] _ in
                guard let self else { return }
                self.updateCountdowns()
            }
        }
    }
    
    private func convertRaceSummariesToViewModel(_ races: [RaceSummary]) -> [RaceSummaryViewModel] {
        return races.map { RaceSummaryViewModel(raceSummary: $0) }
    }
    
    private func updateCountdowns() {
        let currentTime = Date()
        
        // Update the countdown for the displayed races
        var temp: [RaceSummaryViewModel] = []
        for race in allRaces {
            let timeRemaining = race.advertisedStartDate.timeIntervalSince(currentTime)
            race.advertisedStart = timeRemaining
            temp.append(race)
            if timeRemaining < -60.0 {
                countdownTimer?.invalidate()
                Task {
                    await getRaces()
                    return
                }
            }
        }
        allRaces = temp
    }
}

