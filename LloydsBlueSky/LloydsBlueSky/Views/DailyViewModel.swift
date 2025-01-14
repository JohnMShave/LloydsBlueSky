//
//  DailyViewModel.swift
//  LloydsBlueSky
//
//  Created by John Shave on 12/01/2025.
//

import Foundation

@MainActor
class DailyViewModel: ObservableObject {
	
	struct Day: Identifiable {
		let name: String
		var id = UUID()
	}

	let days: [Day] = [
		.init(name: "Monday"),
		.init(name: "Tuesday"),
		.init(name: "Wednesday"),
		.init(name: "Thursday"),
		.init(name: "Friday"),
		.init(name: "Saturday"),
		.init(name: "Sunday"),
	]
	
	let forecastResource: any FullForecastResource
	
	@Published var forecastFetchState = FetchState<FullForecast>.idle

	var summaries = [(tempHigh: Double?, tempLow: Double?)]()

	init(forecastResource: any FullForecastResource) {
		self.forecastResource = forecastResource
	}
	
	func getForecast() async {
		forecastFetchState = .fetching(resource: forecastResource)
		do {
			let fullForecast = try await forecastResource.obtainModel()

			let summaryForecasts = fullForecast.daily.map { $0.temp }
			guard summaryForecasts.isEmpty == false else {
				forecastFetchState = .failed(resource: forecastResource, error: NetworkError.invalidResponse)
				return
			}
			forecastFetchState = .fetched(resource: forecastResource, model: fullForecast)
			summaries = summaryForecasts.map { ($0.max.kelvinAsCelsius, $0.min.kelvinAsCelsius) }
		} catch {
			forecastFetchState = .failed(resource: forecastResource, error: error)
		}
	}
}
