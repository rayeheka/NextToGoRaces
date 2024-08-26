//
//  NextToGoRacesViewModel.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import Foundation
import XCTest
@testable import NextToGoRaces

class NextToGoRacesViewModelTests: XCTestCase {
    var viewModel: NextToGoRacesViewModel!
    var mockRacesManager: MockRacesManager!
    
    override func setUp() {
        super.setUp()
        mockRacesManager = MockRacesManager()
        viewModel = NextToGoRacesViewModel(racesManager: mockRacesManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRacesManager = nil
        super.tearDown()
    }
    
    func testGetRaces() async {
        // Given
        let currentUnixEpochTimeInSeconds = Int(Date().timeIntervalSince1970)
        let race1 = RaceSummary(raceNumber: 1,
                                meetingName: "Meeting 1",
                                categoryId: "9daef0d7-bf3c-4f50-921d-8e818c60fe61",
                                advertisedStartSeconds: AdvertisedStart(seconds: currentUnixEpochTimeInSeconds + 60))
        let race1ViewModel = RaceSummaryViewModel(raceSummary: race1)
        
        let race2 = RaceSummary(raceNumber: 2,
                                meetingName: "Meeting 2",
                                categoryId: "161d9be2-e909-4326-8c2c-35ed71fb460b",
                                advertisedStartSeconds: AdvertisedStart(seconds: currentUnixEpochTimeInSeconds + 120))
        let race2ViewModel = RaceSummaryViewModel(raceSummary: race2)

        mockRacesManager.fetchRacesResult = [race1, race2]
        
        let expectation = self.expectation(description: "This code is async called in Dispatch Queue.main. We should wait till the operation compeletes.")
        // When
        await viewModel.getRaces()
        // Then
        DispatchQueue.main.async { [weak self] in
            XCTAssertEqual(self!.viewModel.filteredRaces, [race1ViewModel, race2ViewModel])
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 3.0)
        
    }
    
    func testFilterBasedOnCategory() async {
        // Given
        let currentUnixEpochTimeInSeconds = Int(Date().timeIntervalSince1970)
        let race1 = RaceSummary(raceNumber: 1,
                                meetingName: "Meeting 1",
                                categoryId: "9daef0d7-bf3c-4f50-921d-8e818c60fe61",
                                advertisedStartSeconds: AdvertisedStart(seconds: currentUnixEpochTimeInSeconds + 60))
        let race1ViewModel = RaceSummaryViewModel(raceSummary: race1)
        let race2 = RaceSummary(raceNumber: 2,
                                meetingName: "Meeting 2",
                                categoryId: "161d9be2-e909-4326-8c2c-35ed71fb460b",
                                advertisedStartSeconds: AdvertisedStart(seconds: currentUnixEpochTimeInSeconds + 120))
        let race2ViewModel = RaceSummaryViewModel(raceSummary: race2)
        
        viewModel.allRaces = [race1ViewModel, race2ViewModel]
        // When
        viewModel.filter(basedOn: .greyhound, isSelected: false)
        // Then
        XCTAssertEqual(viewModel.filteredRaces, [race2ViewModel])
        
        // When
        viewModel.filter(basedOn: .greyhound, isSelected: true)
        // Then
        XCTAssertEqual(viewModel.filteredRaces, [race1ViewModel, race2ViewModel])
        
        // When
        viewModel.filter(basedOn: .harness, isSelected: false)
        // Then
        XCTAssertEqual(viewModel.filteredRaces, [race1ViewModel])
    }
}

extension RaceSummaryViewModel: Equatable {
    public static func == (lhs: RaceSummaryViewModel, rhs: RaceSummaryViewModel) -> Bool {
        return lhs.meetingName == rhs.meetingName &&
        lhs.raceNumber == rhs.raceNumber &&
        lhs.category == rhs.category
    }
}
