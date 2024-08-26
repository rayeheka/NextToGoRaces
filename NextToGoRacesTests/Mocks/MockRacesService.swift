//
//  MockRacesService.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import Foundation
@testable import NextToGoRaces

class MockRacesService: RacesServiceProtocol {
    var mockRaces: Races?
    
    func getNextRaces(numberOfNextRaces: Int) async -> Races? {
        return mockRaces
    }
}
