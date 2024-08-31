//
//  FilterView.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/30/24.
//

import SwiftUI

struct FilterView: View {
    let category: RaceCategory
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: category.image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
            Spacer()
            if isSelected {
                Rectangle()
                    .fill(.red)
                    .frame(height: 4)
            }
        }
        .frame(width: UIScreen.main.bounds.width / 3)
        .onTapGesture {
            isSelected.toggle()
        }
    }
}
