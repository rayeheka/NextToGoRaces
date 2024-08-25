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

class RacesService: RacesServiceProtocol {
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
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
