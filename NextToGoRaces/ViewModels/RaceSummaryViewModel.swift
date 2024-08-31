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
    var formattedAdvertisedStart: String {
        convertSecondsToFormattedTime(seconds: advertisedStart)
    }
    
    init(raceSummary: RaceSummary) {
        self.meetingName = raceSummary.meetingName
        self.raceNumber = raceSummary.raceNumber
        self.category = raceSummary.category
        self.advertisedStartDate = raceSummary.advertisedStart
        self.advertisedStart = raceSummary.advertisedStart.timeIntervalSinceNow
    }
    
    /// convert raw seconds to formatted h min sec
    ///
    /// - Parameters:
    ///     - seconds: A Double that represents seconds to be converted
    /// - Returns: a String in the format of "h min sec"
    private func convertSecondsToFormattedTime(seconds: Double) -> String {
        let intSeconds = Int(seconds)
        let h = intSeconds / 3600
        let min = (intSeconds % 3600) / 60
        let sec = (intSeconds % 3600) % 60
        var convertedString = ""
        if h != 0 { convertedString.append("\(h) h ") }
        if min != 0 { convertedString.append("\(min) m ") }
        convertedString.append("\(sec) s")
        return convertedString
    }
}
