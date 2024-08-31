//
//  RaceSummary.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

struct RaceSummary: Codable, Identifiable {
    var id = UUID()
    
    var raceNumber: Int
    var meetingName: String
    
    private var categoryId: String
    var category: RaceCategory {
        return RaceCategory(rawValue: categoryId)!
    }
    
    private var advertisedStartSeconds: Int
    var advertisedStart: Date {
        Date(timeIntervalSince1970: TimeInterval(advertisedStartSeconds))
    }
    
    enum CodingKeys: String, CodingKey {
        case raceNumber = "race_number"
        case meetingName = "meeting_name"
        case advertisedStartSeconds = "advertised_start"
        case categoryId = "category_id"
    }
    
    enum AdvertisedStartCodingKeys: String, CodingKey {
        case seconds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.raceNumber = try container.decode(Int.self, forKey: .raceNumber)
        self.meetingName = try container.decode(String.self, forKey: .meetingName)
        self.categoryId = try container.decode(String.self, forKey: .categoryId)
        
        let nestedContainer = try container.nestedContainer(keyedBy: AdvertisedStartCodingKeys.self, forKey: .advertisedStartSeconds)
        self.advertisedStartSeconds = try nestedContainer.decode(Int.self, forKey: .seconds)
    }
    
    init(raceNumber: Int, meetingName: String, categoryId: String, advertisedStartSeconds: Int) {
        self.raceNumber = raceNumber
        self.meetingName = meetingName
        self.categoryId = categoryId
        self.advertisedStartSeconds = advertisedStartSeconds
    }
}
