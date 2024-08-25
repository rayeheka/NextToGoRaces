//
//  RaceSummaryViewModel.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

class RaceSummaryViewModel: ObservableObject {
    var meetingName: String
    var raceNumber: Int
    var category: RaceCategory
    var advertisedStartDate: Date
    var advertisedStart: Double
    
    init(raceSummary: RaceSummary) {
        self.meetingName = raceSummary.meetingName
        self.raceNumber = raceSummary.raceNumber
        self.category = raceSummary.category
        self.advertisedStartDate = raceSummary.advertisedStart
        self.advertisedStart = raceSummary.advertisedStart.timeIntervalSinceNow
    }
}
