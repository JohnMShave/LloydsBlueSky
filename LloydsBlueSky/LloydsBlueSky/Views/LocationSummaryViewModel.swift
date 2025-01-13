//
//  LocationSummaryViewModel.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

/// By templating not only the resource but the repository, we have really concise & readable code in our
/// viewModel which can be very easily mocked as the resources themselves are so easy to setup.
/// The other nice thing about this is it's very flexible, requiring minimal code changes if we wanted, for
/// example, to replace the source of our models as we use an identical interface for all resources types.
/// So if we wanted to replace a back end service with a baked in store or maybe one that is created
/// having been fetched on startup, then no code changes are required in our code at this level.
class LocationSummaryViewModel {
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
