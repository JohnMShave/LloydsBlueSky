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

struct DailyForecast {
	var minTemp: Double
	var maxTemp: Double
	var feelsLike: Double
	var clouds: Int
	var windSpeed: Double
	var pop: Double
}

struct HourlyForecast {
	var temp: Double
	var feelsLike: Double
	var clouds: Int
	var windSpeed: Double
	var pop: Double
}
