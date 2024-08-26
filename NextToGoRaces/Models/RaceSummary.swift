//
//  RaceSummary.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

struct RaceSummary: Codable {
    var raceNumber: Int
    var meetingName: String
    
    private var categoryId: String
    var category: RaceCategory {
        return RaceCategory(rawValue: categoryId)!
    }
    
    private var advertisedStartSeconds: AdvertisedStart
    var advertisedStart: Date {
        Date(timeIntervalSince1970: TimeInterval(advertisedStartSeconds.seconds))
    }
    
    enum CodingKeys: String, CodingKey {
        case raceNumber = "race_number"
        case meetingName = "meeting_name"
        case advertisedStartSeconds = "advertised_start"
        case categoryId = "category_id"
    }
    
    init(raceNumber: Int, meetingName: String, categoryId: String, advertisedStartSeconds: AdvertisedStart) {
        self.raceNumber = raceNumber
        self.meetingName = meetingName
        self.categoryId = categoryId
        self.advertisedStartSeconds = advertisedStartSeconds
    }
}
