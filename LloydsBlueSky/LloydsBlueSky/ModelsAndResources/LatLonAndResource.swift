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

	/// As mentioned in NetworkResource comments, this would be build more conventionally
	/// given more time but I'm assuming we're happy that that is essentially boiler plate anyway.
	var url: URL? {
		URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(locationName)&limit=5&appid=\(Network.apiKey)")
	}
}

/// Very simple mocking without need to mock network clients for every type model being fetched.
/// We can simply inject this into a view model and no further work is required to see that the view
/// model behaves correctly based on mock data.
/// This is achieved by somewhat turning conventional approach on it's head since it's now a
/// `Resource` (or rather the data used to fetch a model) that implicitly knows `how` to fetch
/// that model which is why we only need to mock the Resource itself.
/// By encapsulating the data used to `obtain` a model and the logic to `obtain` the model,
/// we abstract that `obtaining` logic out of the repository meaning we don't need boiler-plate
/// variants of a repo per `instance` of a resource `Type` or its respective mocks and tests.
struct MockLatLonResource: NetworkJSONModelRepoResource {
	typealias Model = LatLon
	
	var url: URL?
	
	func obtainModel() -> LatLon {
		LatLon(lat: 1, lon: 1)
	}
}
