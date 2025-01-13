//
//  LocationSummaryViewModel.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

enum FetchState<Model: Equatable>: Equatable {
	case idle
	case fetching(resource: any RepoResource)
	case fetched(resource: any RepoResource, model: Model)
	case failed(resource: any RepoResource, error: any Error)
	
	static func ==(lhs: FetchState, rhs: FetchState) -> Bool {
		switch (lhs, rhs) {
		case (.fetching, .fetching), (.failed, .failed):
			return true
		case (let .fetched(_, modelLhs), let .fetched(_, modelRhs)):
			return modelLhs == modelRhs
		default:
			return false
		}
	}
	
	var model: Model? {
		switch self {
		case .fetched(resource: let resource, model: let model):
			return model
		default:
			return nil
		}
	}
}

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
class LocationSummaryViewModel: ObservableObject {
	let latLonResource: any RepoResource
	let dailyResource: any RepoResource
	
	@Published var latLonFetchState = FetchState<LatLon>.idle
	@Published var dailyForecastsFetchState = FetchState<[DailyForecast]>.idle
	
	var summary: (tempHigh: Double, tempLow: Double)? {
		guard let dailyForecast = dailyForecastsFetchState.model?.first else { return nil }
		return (dailyForecast.maxTemp, dailyForecast.minTemp)
	}
		
	init(latLonResource: any RepoResource = LatLonResource(locationName: "London"),
			 dailyResource: any RepoResource = DailyResource(latLon: nil)
	) {
		self.latLonResource = latLonResource
		self.dailyResource = dailyResource
	}
	
	func getLatLon() async {
		latLonFetchState = .fetching(resource: latLonResource)
		do {
			let latLon = try await latLonResource.obtainModel() as! LatLon
			latLonFetchState = .fetched(resource: latLonResource, model: latLon)
			await getDaily()
		} catch {
			latLonFetchState = .failed(resource: latLonResource, error: error)
		}
	}
	
	func getDaily() async {
		dailyForecastsFetchState = .fetching(resource: dailyResource)
		do {
			let dailyForecasts = try await dailyResource.obtainModel() as! [DailyForecast]
			dailyForecastsFetchState = .fetched(resource: dailyResource, model: dailyForecasts)
		} catch {
			dailyForecastsFetchState = .failed(resource: dailyResource, error: error)
		}
	}
}
