//
//  Untitled.swift
//  LloydsBlueSky
//
//  Created by John Shave on 09/01/2025.
//

import Foundation

struct LatLonNetworkResource {
	let locationName: String
	var url: URL? {
		URL.init(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(locationName)&limit=5&appid=\(Network.apiKey)")
	}
}
