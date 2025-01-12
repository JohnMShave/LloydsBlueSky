//
//  DailyView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

struct Day: Identifiable {
	let name: String
	var id = UUID()
}

struct DailyView: View {
	@EnvironmentObject private var coordinator: Coordinator
	@EnvironmentObject private var forecastContext: ForecastContext
	
	let days: [Day] = [
		Day(name: "Monday"),
		Day(name: "Tuesday"),
		Day(name: "Wednesday"),
		Day(name: "Thursday"),
		Day(name: "Friday"),
		Day(name: "Saturday"),
		Day(name: "Sunday"),
	]

	var body: some View {
		VStack {
			Spacer()
			List {
				ForEach(days) { day in
					SummaryView(title: day.name, tempHigh: 20, tempLow: 10)
						.listItemTapable {
							coordinator.presentPageType(.hourly(day: day.name), usingStyle: .cover)
						}
						.listRowSeparator(.hidden)
				}
			}
		}
		.padding(16)
	}
}
