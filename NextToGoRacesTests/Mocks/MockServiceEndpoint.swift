//
//  MockServiceEndpoint.swift
//  NextToGoRacesTests
//
//  Created by Rayeheh Karimanipour on 8/26/24.
//

import Foundation
@testable import NextToGoRaces

struct MockServiceEndpoint: ServiceEndpointProtocol {
    var path: String = "/mock"
    var httpMethod: HTTPMethod = .get
}
