//
//  MockRacesManager.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import Foundation
@testable import NextToGoRaces

class MockRacesManager: RacesManagerProtocol {
    var fetchRacesResult: [RaceSummary] = []
    
    func fetchRaces() async -> [RaceSummary] {
        return fetchRacesResult
    }
}
