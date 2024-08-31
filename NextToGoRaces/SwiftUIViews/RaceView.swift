//
//  RaceView.swift
//  NextToGoRaces
//
//  Created by Rayeheh Karimanipour on 8/30/24.
//

import SwiftUI

struct RaceView: View {
    @ObservedObject var raceSummary: RaceSummaryViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(uiImage: raceSummary.category.image)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                Text(raceSummary.meetingName)
                    .font(.body)
                    .foregroundColor(.black)
                
                Image(systemName: "\(raceSummary.raceNumber).circle.fill")
                    .foregroundColor(.black)
            }

            Spacer()
            
            Text(raceSummary.formattedAdvertisedStart)
                .font(.subheadline)
                .foregroundColor(.red)
                .frame(alignment: .trailing)
        }
        .padding(.vertical, 4)
    }
}
