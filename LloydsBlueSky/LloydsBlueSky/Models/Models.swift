//
//  CoordAndForecastsRepo.swift
//  LloydsBlueSky
//
//  Created by John Shave on 08/01/2025.
//

import Foundation

struct LatLon: Decodable {
	var lat, lon: Double
}

struct DailyForecast: Decodable {
	var minTemp: Double
	var maxTemp: Double
}

struct HourlyForecast: Decodable {
	var temp: Double
	var feelsLike: Double
	var clouds: Int
	var windSpeed: Double
	var pop: Double
}
