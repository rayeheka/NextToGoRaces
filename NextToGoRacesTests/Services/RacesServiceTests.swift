//
//  RacesServiceTests.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import XCTest
@testable import NextToGoRaces

class RacesServiceTests: XCTestCase {
    var racesService: RacesService!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        racesService = RacesService(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        racesService = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testGetNextRaces_returnsRaces() async {
        // Given
        let currentUnixEpochTimeInSeconds = Int(Date().timeIntervalSince1970)
        let expectedRaces = Races(nextToGoIds: ["1", "2"],
                                  raceSummaries: ["1": RaceSummary(raceNumber: 1,
                                                                   meetingName: "Meeting 1",
                                                                   categoryId: "Category 1",
                                                                   advertisedStartSeconds: currentUnixEpochTimeInSeconds - 70),
                                                  "2": RaceSummary(raceNumber: 2,
                                                                   meetingName: "Meeting 2",
                                                                   categoryId: "Category 2",
                                                                   advertisedStartSeconds: currentUnixEpochTimeInSeconds + 20)])
        mockNetworkService.mockResponse = expectedRaces
        
        
        let races = await racesService.getNextRaces(numberOfNextRaces: 2)
        
        XCTAssertEqual(races?.nextToGoIds.count, 2)
    }
}
