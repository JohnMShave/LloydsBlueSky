//
//  HourlyView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

struct HourlyView: View {
	@EnvironmentObject private var coordinator: Coordinator
	@EnvironmentObject private var forecastContext: ForecastContext
	
	let dayName: String
	
	var body: some View {
		VStack {
			Text("\(forecastContext.locationName) - Summary")
				.font(.title)
				.padding()
			Text(dayName)
				.font(.title)
				.padding()
			Button(action: {
				coordinator.dismissCover()
			}) {
				Text("Dismiss")
					.foregroundColor(.blue)
			}
			.padding(.bottom, 20)
		}
	}
}
