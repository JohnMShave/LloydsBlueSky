//
//  DailyForecastAndResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

struct DailyForecast: Equatable, Decodable {
	var minTemp: Double
	var maxTemp: Double
}

struct DailyResource: NetworkJSONModelRepoResource {
	typealias Model = [DailyForecast]

	let latLon: LatLon?

	var url: URL? {
		guard let lat = latLon?.lat, let lon = latLon?.lon else { return nil }
		return URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(Network.apiKey)")
	}
}

struct MockDailyResource: NetworkJSONModelRepoResource {
	typealias Model = [DailyForecast]
	
	var url: URL?
	
	func obtainModel() -> [DailyForecast] {
		[DailyForecast(minTemp: 12, maxTemp: 13)]
	}
}
