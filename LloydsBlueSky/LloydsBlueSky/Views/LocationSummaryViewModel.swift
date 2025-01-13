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
class LocationSummaryViewModel: ObservableObject {
	let latLonResource: any RepoResource
	let dailyResource: any RepoResource
	
	var latLon: LatLon?
	
	init(latLonResource: any RepoResource = LatLonResource(locationName: "London"),
			 dailyResource: any RepoResource = DailyResource(latLon: nil)
	) {
		self.latLonResource = latLonResource
		self.dailyResource = dailyResource
	}
	
	func fetchLatLon() {
		latLon = latLonResource.obtainModel() as? LatLon
	}
	
	func daily() -> [DailyForecast]? {
		dailyResource.obtainModel() as? [DailyForecast]
	}
}
