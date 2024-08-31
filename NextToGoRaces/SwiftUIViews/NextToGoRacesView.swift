//
//  NextToGoRacesView.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/30/24.
//

import SwiftUI

struct NextToGoRacesView: View {
    @ObservedObject var viewModel: NextToGoRacesViewModel
    
    var body: some View {
        HStack {
            ForEach(RaceCategory.allCases, id: \.self) { category in
                FilterView(category: category,
                           isSelected: Binding(
                            get: { viewModel.selectedCategories.contains(category) },
                            set: { isSelected in viewModel.filter(basedOn: category, isSelected: isSelected) }
                           ))
            }
        }
        .frame(height: 100)
        Spacer()
        VStack {
            List {
                ForEach(viewModel.filteredRaces) { race in
                    RaceView(raceSummary: race)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getRaces()
                }
            }
        }
    }
}
