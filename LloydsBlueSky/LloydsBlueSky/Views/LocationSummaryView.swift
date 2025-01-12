//
//  LocationSummaryView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

struct LocationSummaryView: View {
	
	@EnvironmentObject private var coordinator: Coordinator
	@EnvironmentObject private var forecastContext: ForecastContext
	
	var body: some View {
		VStack {
			Text("\(forecastContext.locationName) - Summary")
			Spacer()
			dailyViewButton
		}
		.padding(16)
	}
	
	var dailyViewButton: some View {
		Button {
			coordinator.presentPage(.daily, withStyle: .screen)
		} label: {
			Text("Daily Summary")
				.font(.title3)
				.foregroundStyle(.white)
				.padding(16)
		}
		.frame(maxWidth: .infinity)
		.background(Color.blue)
		.clipShape(.buttonBorder)
	}
}
