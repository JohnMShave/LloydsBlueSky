//
//  MockLatLonResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 14/01/2025.
//

import Foundation
@testable import LloydsBlueSky

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
