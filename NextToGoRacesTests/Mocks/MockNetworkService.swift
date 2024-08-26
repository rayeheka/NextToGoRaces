//
//  MockNetworkService.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import Foundation
@testable import NextToGoRaces

class MockNetworkService: NetworkServiceProtocol {
    var mockResponse: Any?
    
    func request<T>(endpoint: any ServiceEndpointProtocol) async throws -> T where T : Decodable {
        if let response = mockResponse as? T {
            return response
        }
        throw NetworkError.decodingError
    }
}
