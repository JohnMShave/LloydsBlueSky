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

	@ObservedObject private var viewModel: DailyViewModel
	@State private var summaries = Array(repeating: (nil as Double?, nil as Double?), count: 7)
	@State private var isLoading = true
	
	init(latLon: LatLon) {
		self.viewModel = DailyViewModel(forecastResource: ForecastResource(latLon: latLon))
	}
	
	var body: some View {
		VStack {
			Text("\(forecastContext.locationName) - Daily")
				.accessibilityIdentifier("daily.text.locationName")
				.accessibilityLabel(forecastContext.locationName)
				.foregroundColor(.text)
			Spacer()
			List {
				ForEach(0..<7) { dayIndex in
					SummaryView(
						title: viewModel.days[dayIndex].name,
						tempHigh: summaries[dayIndex].0,
						tempLow: summaries[dayIndex].1
					)
						.listItemTapable {
							coordinator.presentPageType(.hourly(day: viewModel.days[dayIndex].name), usingStyle: .cover)
						}
						.listRowSeparator(.hidden)
				}
			}
			.background(.raisedBackground)
		}
		.padding(16)
		.background(.backgroundUnraised)
		.task {
			isLoading = true
			await viewModel.getForecast()
		}
		.onChange(of: viewModel.forecastFetchState) {
			forecastDidChange()
		}
	}
	
	private func forecastDidChange() {
		switch viewModel.forecastFetchState {
		case .idle:
			break
		case .fetching(resource: _):
			isLoading = true
		case .fetched(resource: _, model: _):
			summaries = viewModel.summaries
			isLoading = false
		case .failed(_, error: let error):
			print("Show error - \(error.localizedDescription)")
			isLoading = false
		}
	}
}
