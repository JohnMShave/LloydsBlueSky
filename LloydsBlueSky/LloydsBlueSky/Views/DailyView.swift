//
//  DailyView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

struct DailyView: View {
	@EnvironmentObject private var coordinator: Coordinator
	@EnvironmentObject private var forecastContext: ForecastContext
	
	let days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

	var body: some View {
		VStack {
			Text("\(forecastContext.locationName) - Summary")
			Spacer()
			List {
				ForEach(days.count) { day in
					NavigationLink(destination: HourlyView(day: day)) {
						Text("\(day)")
					}
				}
			}
		}
		.padding(16)
	}
}
