//
//  MockForecastResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 14/01/2025.
//

import Foundation
@testable import LloydsBlueSky

/// Here we need to implement FullForecastResource since the viewmodel code using it
/// expects a latLon to be present to set. Again though, no need for any networking capability.
struct MockForecastResource: FullForecastResource {
	typealias Model = FullForecast

	var latLon: LatLon?

	func obtainModel() -> FullForecast {
		FullForecast(
			daily: [
				DetailedForecast(temp: TempRange(min: 284, max: 287)),
				DetailedForecast(temp: TempRange(min: 278, max: 279)),
				DetailedForecast(temp: TempRange(min: 286, max: 291)),
			]
		)
	}
}
