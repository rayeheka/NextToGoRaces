//
//  Races.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

struct Races: Decodable {
    var nextToGoIds: [String]
    var raceSummaries: [String: RaceSummary]
    
    enum CodingKeys: String, CodingKey {
        case nextToGoIds = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}
