//
//  HourlyForecastAndResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

struct HourlyForecast: Decodable {
	var temp: Double
	var feelsLike: Double
	var clouds: Int
	var windSpeed: Double
	var pop: Double
}

struct HourlyResource: NetworkJSONModelRepoResource {
	typealias Model = [HourlyForecast]

	let latLon: LatLon?

	var url: URL? {
		guard let lat = latLon?.lat, let lon = latLon?.lon else { return nil }
		return URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(Network.apiKey)")
	}
}

struct MockHourlyResource: NetworkJSONModelRepoResource {
	typealias Model = [HourlyForecast]
	
	var url: URL?
	
	func obtainModel() -> [HourlyForecast] {
		[HourlyForecast(temp: 12, feelsLike: 13, clouds: 14, windSpeed: 15, pop: 16)]
	}
}
