//
//  ForecastAndResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

struct FullForecast: Equatable, Decodable {
	var daily: [DetailedForecast]
}

struct DetailedForecast: Equatable, Decodable {
	var temp: TempRange
}

struct TempRange: Equatable, Decodable {
	var min: Double
	var max: Double
}

/// We want to allow injection of a Resource type that returns a FullForecast for our mocking but not
/// force the Mock to be a network resource type meaning it needs a url etc
protocol FullForecastResource: RepoResource where Model == FullForecast {
	var latLon: LatLon? { get set }
}

struct ForecastResource: FullForecastResource, NetworkJSONModelRepoResource {
	typealias Model = FullForecast

	var latLon: LatLon?

	var url: URL? {
		guard let lat = latLon?.lat, let lon = latLon?.lon else { return nil }
		return URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(Network.apiKey)")
	}
}

/// Here we need to implement FullForecastResource since the viewmodel code using it
/// expects a latLon to be present to set. Again though, no need for any networking capability.
struct MockForecastResource: FullForecastResource {
	typealias Model = FullForecast

	var latLon: LatLon?

	func obtainModel() -> FullForecast {
		FullForecast(
			daily: [
				DetailedForecast(temp: TempRange(min: 12, max: 16))
			]
		)
	}
}
