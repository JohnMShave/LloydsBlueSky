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

	@ObservedObject private var viewModel = DailyViewModel()

	var body: some View {
		VStack {
			Text("\(forecastContext.locationName) - Daily")
				.accessibilityIdentifier("daily.text.locationName")
				.accessibilityLabel(forecastContext.locationName)
				.foregroundColor(.text)
			Spacer()
			List {
				ForEach(viewModel.days) { day in
					SummaryView(title: day.name, tempHigh: 20, tempLow: 10)
						.listItemTapable {
							coordinator.presentPageType(.hourly(day: day.name), usingStyle: .cover)
						}
						.listRowSeparator(.hidden)
				}
			}
			.background(.raisedBackground)
		}
		.padding(16)
		.background(.backgroundUnraised)
	}
}
