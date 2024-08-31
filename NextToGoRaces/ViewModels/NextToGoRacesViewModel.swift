//
//  NextToGoRacesViewModel.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation
import Combine

/// A viewModel as a base for preparing list of races
/// Can be used separately for the simplest use.
/// RacesManager should be provided to get the list.
/// Handles fetching data, counting down timer and filter races by category.
class NextToGoRacesViewModel: ObservableObject {
    //MARK: - Properties
    @Published var filteredRaces: [RaceSummaryViewModel] = []
    
    var allRaces: [RaceSummaryViewModel] = []
    
    private var selectedCategories: Set<RaceCategory> = Set(RaceCategory.allCases)
    
    private var racesManager: RacesManagerProtocol
    
    private var countdownTimer: AnyCancellable?
    private let countdownInterval: TimeInterval = 1.0
    
    //MARK: - Init
    init(racesManager: RacesManagerProtocol) {
        self.racesManager = racesManager
    }
    
    //MARK: - Methods
    
    /// This function fetches latest races.
    @MainActor
    func getRaces() async {
        let races = await racesManager.fetchRaces()
        let convertedRaces = convertRaceSummariesToViewModel(races)
        filteredRaces = convertedRaces.applyFilter(basedOn: selectedCategories)
        allRaces = convertedRaces
        
        // Schedule countdown updates every `countdownInterval` seconds to show smooth seconds changing
        countdownTimer = Timer.publish(every: countdownInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateCountdowns()
            }
    }
    
    /// This function filters races based on category.
    ///
    /// - Parameters:
    ///     - category: category based on which data is filtered.
    ///     - isSelected: a Boolean to show filter is selected/deselected.
    func filter(basedOn category: RaceCategory, isSelected: Bool) {
        if isSelected {
            selectedCategories.insert(category)
        } else {
            selectedCategories.remove(category)
        }
        
        filteredRaces = allRaces.applyFilter(basedOn: selectedCategories)
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
            //check if any race past 1 minute of its start time
            if timeRemaining < -60.0 {
                countdownTimer?.cancel()
                countdownTimer = nil
                Task {
                    await getRaces()
                    return
                }
            }
        }
        filteredRaces = temp.applyFilter(basedOn: selectedCategories)
    }
}

