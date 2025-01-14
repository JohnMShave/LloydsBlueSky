//
//  HourlyView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

/// Stubbed out purely to show sheet navigation when tapping on a day's summary in DailyView
struct HourlyView: View {
	@EnvironmentObject private var coordinator: Coordinator
	@EnvironmentObject private var forecastContext: ForecastContext
	
	let dayName: String
	
	var body: some View {
		VStack {
			Text("\(forecastContext.locationName) - Hourly")
				.font(.title)
				.padding()
				.background(.raisedBackground)
			Text(dayName)
				.font(.title)
				.padding()
				.background(.raisedBackground)
			dismissButton
		}
		.background(.raisedBackground)
	}
	
	private var dismissButton: some View {
		Button {
			coordinator.dismissCover()
		} label: {
			Text("Back to Daily")
				.font(.title3)
				.foregroundStyle(.white)
				.padding(16)
				.foregroundColor(.text)
		}
		.frame(maxWidth: .infinity)
		.background(.buttonBackground)
		.clipShape(.buttonBorder)
		.accessibilityIdentifier("locationsummary.dailybutton")
	}

}
