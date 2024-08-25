//
//  RacesManager.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

protocol RacesManagerProtocol {
    func fetchRaces() async -> [RaceSummary]
}

class RacesManager: RacesManagerProtocol {
    private var numberOfRacesToFetch: Int
    private var numberOfRacesToShow: Int
    private var racesService: RacesServiceProtocol
 
    private var latestRaces: [RaceSummary] = []
    
    init(racesService: RacesServiceProtocol, numberOfRacesToFetch: Int, numberOfRacesToShow: Int) {
        self.racesService = racesService
        self.numberOfRacesToFetch = numberOfRacesToFetch
        self.numberOfRacesToShow = numberOfRacesToShow
    }
    
    func fetchRaces() async -> [RaceSummary] {
        guard let races = await racesService.getNextRaces(numberOfNextRaces: numberOfRacesToFetch) else { return [] }
        let latestSortedRaces = getLatestRaces(races, numberOfRacesToShow: numberOfRacesToShow)
        latestRaces = latestSortedRaces
        return latestSortedRaces
    }
    
    private func getLatestRaces(_ races: Races, numberOfRacesToShow: Int) -> [RaceSummary] {
        let sortedSummaries = sortRaceSummaries(races: races)
        return Array(sortedSummaries.prefix(numberOfRacesToShow))
    }
    
    private func sortRaceSummaries(races: Races) -> [RaceSummary] {
        let summaries = extractRaceSummaries(races: races)
        return summaries.sorted { $0.advertisedStart < $1.advertisedStart }
    }
    
    private func extractRaceSummaries(races: Races) -> [RaceSummary] {
        var summaries = Array<RaceSummary>()
        for id in races.nextToGoIds {
            if let summary = races.raceSummaries[id],
               summary.advertisedStart.timeIntervalSinceNow > -60.0 {
                summaries.append(summary)
            }
        }
        return summaries
    }
}

