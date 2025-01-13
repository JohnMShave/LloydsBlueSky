//
//  LatLonAndResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 08/01/2025.
//

import Foundation

struct LatLon: Decodable {
	var lat, lon: Double
}

struct LatLonResource: NetworkJSONModelRepoResource {
	typealias Model = LatLon
	
	let locationName: String

	var url: URL? {
		URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(locationName)&limit=5&appid=\(Network.apiKey)")
	}
}

struct MockLatLonResource: NetworkJSONModelRepoResource {
	typealias Model = LatLon
	
	var url: URL?
	
	func obtainModel() -> LatLon {
		LatLon(lat: 1, lon: 1)
	}
}
