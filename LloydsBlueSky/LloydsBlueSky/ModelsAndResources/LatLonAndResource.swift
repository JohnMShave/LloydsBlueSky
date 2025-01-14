//
//  LatLonAndResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 08/01/2025.
//

import Foundation

struct LatLon: Equatable, Decodable, Hashable {
	var lat, lon: Double
}

struct LatLonResource: NetworkJSONModelRepoResource {
	typealias Model = [LatLon]
	
	let locationName: String

	/// As mentioned in NetworkResource comments, this would be build more conventionally
	/// given more time but I'm assuming we're happy that that is essentially boiler plate anyway.
	var url: URL? {
		URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(locationName)&limit=5&appid=\(Network.apiKey)")
	}
}
