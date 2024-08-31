//
//  NextToGoRacesApp.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/30/24.
//

import SwiftUI

@main
struct NextToGoRacesApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppMainScreen()
        }
    }
}

fileprivate struct AppMainScreen: View {
    var body: some View {
        let urlSessionService = URLSessionService()
        let racesService = RacesService(networkService: urlSessionService)
        let numberOfRacesToFetch = 10
        let numberOfRacesToShow = 5
        let racesManager = RacesManager(racesService: racesService, numberOfRacesToFetch: numberOfRacesToFetch, numberOfRacesToShow: numberOfRacesToShow)
        let viewModel = NextToGoRacesViewModel(racesManager: racesManager)
        NextToGoRacesView(viewModel: viewModel)
    }
    
}
