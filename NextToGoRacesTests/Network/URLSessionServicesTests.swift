//
//  URLSessionServices.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import XCTest
@testable import NextToGoRaces

class URLSessionServiceTests: XCTestCase {
    var urlSessionService: URLSessionService!
    var mockURLSession: MockURLSession!
    var mockServiceEndpoint: MockServiceEndpoint!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        mockServiceEndpoint = MockServiceEndpoint()
        urlSessionService = URLSessionService(urlSession: mockURLSession)
    }
    
    override func tearDown() {
        urlSessionService = nil
        mockURLSession = nil
        mockServiceEndpoint = nil
        super.tearDown()
    }
    
    func testRequest_returnsDecodedData() async throws {
        //Given
        let expectedData = BaseResponse(status: 200, data: "Data")
        mockURLSession.mockData = try JSONEncoder().encode(expectedData)
        // When
        let response: String = try await urlSessionService.request(endpoint: mockServiceEndpoint)
        // Then
        XCTAssertEqual(response, "Data")
    }
    
    func testRequest_throwsDecodingError() async {
        //Given
        mockURLSession.mockData = Data() // Invalid data for decoding
        
        do {
            // When
            let _: String = try await urlSessionService.request(endpoint: mockServiceEndpoint)
            XCTFail("Expected decoding error")
        } catch let error as NetworkError {
            // Then
            XCTAssertEqual(error, .networkFailure(NetworkError.decodingError))
        } catch {
            // Then
            XCTFail("Unexpected error: \(error)")
        }
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        case (.decodingError, .decodingError):
            return true
        case (.networkFailure(let lhsError as NetworkError), .networkFailure(let rhsError as NetworkError)):
            return lhsError == rhsError
        case (.networkFailure(let lhsError), .networkFailure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
