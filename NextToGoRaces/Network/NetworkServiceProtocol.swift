//
//  NetworkServiceProtocol.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: any ServiceEndpointProtocol) async throws -> T
}
