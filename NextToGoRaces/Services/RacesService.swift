//
//  RacesService.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/25/24.
//

import Foundation

protocol RacesServiceProtocol {
    func getNextRaces(numberOfNextRaces: Int) async -> Races?
}

/// The `RacesService` is responsible for managing and fetching race data from the network.
/// It interacts with a network service to retrieve races data
class RacesService: RacesServiceProtocol {
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    /// Fetches the latest races from the network
    ///
    /// Parameter numberOfNextRaces: number of races to be fetched from server
    /// Returns: Races model
    func getNextRaces(numberOfNextRaces: Int) async -> Races? {
        do {
            let endpointToCall = getRacesServiceEndpoint(numberOfNextRaces: numberOfNextRaces)
            let race: Races = try await networkService.request(endpoint: endpointToCall)
            return race
        } catch let error as NetworkError {
            print(error.errorDescription)
            return nil
        } catch {
            print("Unhandled Error: \(error)")
            return nil
        }
    }
    
    private func getRacesServiceEndpoint(numberOfNextRaces: Int) -> ServiceEndpointProtocol {
        return RacesServiceEndpoint(numberOfNextRaces: numberOfNextRaces)
    }
}
