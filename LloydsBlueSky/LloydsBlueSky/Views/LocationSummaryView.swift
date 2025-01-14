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
	
	@ObservedObject private var viewModel = LocationSummaryViewModel()
	@State private var summary: (Double?, Double?)
	@State private var isLoading = true
	@State var latLon: LatLon?
	
	var body: some View {
		
		VStack {
			Text("\(forecastContext.locationName) - Summary")
				.accessibilityIdentifier("locationsummary.text.locationname")
				.accessibilityLabel(forecastContext.locationName)
			if isLoading {
				ProgressView()
			} else {
				Spacer()
				SummaryView(title: "Current", tempHigh: summary.0, tempLow: summary.1)
				Spacer()
			}
			dailyViewButton
		}
		.padding(16)
		.background(.backgroundUnraised)
		.task {
			// Check if it's first time we're landing on screen / if we need to fetch
			if summary.0 == nil || summary.1 == nil {
				isLoading = true
				await viewModel.getLatLon()
			}
		}
		.onChange(of: viewModel.latLonFetchState) {
			latLonDidChange()
		}
		.onChange(of: viewModel.forecastFetchState) {
			forecastDidChange()
		}
	}
	
	private func latLonDidChange() {
		switch viewModel.latLonFetchState {
		case .idle, .fetched:
			break
		case .fetching:
			isLoading = true
		case .failed(_, error: let error):
			print("Show error - \(error.localizedDescription)")
			isLoading = false
		}
	}

	private func forecastDidChange() {
		switch viewModel.forecastFetchState {
		case .idle:
			break
		case .fetching(resource: _):
			// Don't need to do this but future proofing against getForecast() getting called
			// again without invoking getLatLon (e.g. after a refactor adding a refresh).
			isLoading = true
		case .fetched(resource: _, model: _):
			summary = viewModel.summary
			isLoading = false
			latLon = viewModel.latLonFetchState.model
		case .failed(_, error: let error):
			print("Show error - \(error.localizedDescription)")
			isLoading = false
		}
	}
	
	private var dailyViewButton: some View {
		Button {
			if let latLon {
				coordinator.presentPageType(.daily(latLon: latLon), usingStyle: .screen)
			}
		} label: {
			Text("Daily Summary")
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
