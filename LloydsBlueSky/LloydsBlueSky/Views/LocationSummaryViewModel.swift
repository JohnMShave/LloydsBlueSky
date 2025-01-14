//
//  LocationSummaryViewModel.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

/// By templating not only the resource but the repository, we have really concise & readable code in our
/// viewModel which can be very easily mocked by mocking the resource which is trivial to setup.
///
/// The other nice thing about this is it's flexibility, requiring minimal code changes if we wanted, for
/// example, to replace the source of our models, as we use an identical interface for all resources types.
/// So if we wanted to replace a back end service with a baked in store or maybe one that is created
/// having been fetched on startup, then no code changes are required in our code at this level.
///
/// This is an example of inverse dependancy at play, where our owning object declares the interface and
/// it's usage (in this case `any RepoResource`) and whatever we want to supply our models must
/// adhere to that, as opposed to this maybe needing to adhere to a Resource's delegate implementation.
@MainActor
class LocationSummaryViewModel: ObservableObject {
	let latLonResource: any RepoResource
	var forecastResource: any FullForecastResource
	
	@Published var latLonFetchState = FetchState<LatLon>.idle
	@Published var forecastFetchState = FetchState<FullForecast>.idle

	var summary: (tempHigh: Double?, tempLow: Double?) = (nil, nil)
		
	init(latLonResource: any RepoResource = LatLonResource(locationName: "London"),
			 forecastResource: any FullForecastResource = ForecastResource(latLon: nil)
	) {
		self.latLonResource = latLonResource
		self.forecastResource = forecastResource
	}
	
	func getLatLon() async {
		latLonFetchState = .fetching(resource: latLonResource)
		do {
			let latLons = try await latLonResource.obtainModel() as! [LatLon]
			guard let latLon = latLons.first else {
				latLonFetchState = .failed(resource: latLonResource, error: NetworkError.invalidResponse)
				return
			}
			latLonFetchState = .fetched(resource: latLonResource, model: latLon)
			forecastResource.latLon = latLon
			await getForecast()
		} catch {
			latLonFetchState = .failed(resource: latLonResource, error: error)
		}
	}
	
	func getForecast() async {
		forecastFetchState = .fetching(resource: forecastResource)
		do {
			let fullForecast = try await forecastResource.obtainModel()
			
			guard let summaryForecast = fullForecast.daily.first?.temp else {
				forecastFetchState = .failed(resource: forecastResource, error: NetworkError.invalidResponse)
				return
			}
			forecastFetchState = .fetched(resource: forecastResource, model: fullForecast)
			summary = (summaryForecast.max.kelvinAsCelsius, summaryForecast.min.kelvinAsCelsius)
		} catch {
			forecastFetchState = .failed(resource: forecastResource, error: error)
		}
	}
}

/// This should live in a more obvious shared place
extension Double {
	var kelvinAsCelsius: Double { self - 273.15 }
}
