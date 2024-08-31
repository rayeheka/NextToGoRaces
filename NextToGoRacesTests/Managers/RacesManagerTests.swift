//
//  RacesManagerTests.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import XCTest
@testable import NextToGoRaces

class RacesManagerTests: XCTestCase {
    var racesManager: RacesManager!
    var mockRacesService: MockRacesService!
    
    override func setUp() {
        super.setUp()
        mockRacesService = MockRacesService()
        racesManager = RacesManager(racesService: mockRacesService, numberOfRacesToFetch: 5, numberOfRacesToShow: 2)
    }
    
    override func tearDown() {
        racesManager = nil
        mockRacesService = nil
        super.tearDown()
    }
    
    func testFetchRacesSuccess_startedAfterOneMinuteAgo() async {
        // Given
        let currentUnixEpochTimeInSeconds = Int(Date().timeIntervalSince1970)
        mockRacesService.mockRaces = Races(nextToGoIds: ["1", "2", "3", "4", "5"],
                                           raceSummaries: ["1": RaceSummary(raceNumber: 1,
                                                                            meetingName: "Meeting 1",
                                                                            categoryId: "Category 1",
                                                                            advertisedStartSeconds: currentUnixEpochTimeInSeconds + 10),
                                                           "2": RaceSummary(raceNumber: 2,
                                                                            meetingName: "Meeting 2",
                                                                            categoryId: "Category 2",
                                                                            advertisedStartSeconds: currentUnixEpochTimeInSeconds + 20)])
        // When
        let races = await racesManager.fetchRaces()
        // Then
        XCTAssertEqual(races.count, 2)
    }
    
    func testFetchRacesSuccess_startedBeforeOneMinuteAgo() async {
        // Given
        let currentUnixEpochTimeInSeconds = Int(Date().timeIntervalSince1970)
        mockRacesService.mockRaces = Races(nextToGoIds: ["1", "2", "3", "4", "5"],
                                           raceSummaries: ["1": RaceSummary(raceNumber: 1,
                                                                            meetingName: "Meeting 1",
                                                                            categoryId: "Category 1",
                                                                            advertisedStartSeconds: currentUnixEpochTimeInSeconds - 70),
                                                           "2": RaceSummary(raceNumber: 2,
                                                                            meetingName: "Meeting 2",
                                                                            categoryId: "Category 2",
                                                                            advertisedStartSeconds: currentUnixEpochTimeInSeconds + 20)])
        // When
        let races = await racesManager.fetchRaces()
        // Then
        XCTAssertEqual(races.count, 1)
    }
}



