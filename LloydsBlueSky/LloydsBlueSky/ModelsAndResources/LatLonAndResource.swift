//
//  LatLonAndResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 08/01/2025.
//

import Foundation

struct LatLon: Equatable, Decodable {
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

/// Very simple mocking without need to mock network clients for every model type being fetched.
/// We can simply inject this into a view model to see that it behaves correctly based on mock data.
///
/// This is achieved by somewhat turning conventional approach on it's head since it's now a
/// `Resource` - the data used to fetch a model - that implicitly knows `how` to fetch that
/// model which is why we need to mock the Resource itself.
///
/// By encapsulating the data used to `obtain` a model with the logic to `obtain` the model,
/// we abstract that `obtaining` logic out of the repository meaning we don't need boiler-plate
/// variants of a repo per `instance` of a resource `Type` or its respective mocks and tests.
///
/// Here we can create a Mock that doesn't need to be "networkable" so no need for URL as it
/// wont invoke a network repo fetch.
struct MockLatLonResource: RepoResource {
	typealias Model = [LatLon]
	
	func obtainModel() -> [LatLon] {
		[LatLon(lat: 1, lon: 1)]
	}
}
