//
//  NetworkJSONModelRepository.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

class NetworkJSONModelRepository<Resource: NetworkJSONModelRepoResource>: Repository {
	typealias RepoResource = Resource
	
	func convertJSONToData<T: Encodable>(item: T) -> Data? {
			do {
					let encodedJSON = try JSONEncoder().encode(item)
					return encodedJSON
			} catch {
					return nil
			}
	}
	
	let json = """
		[
			{
				"name": "London",
				"lat": 37.1289771,
				"lon": -84.0832646,
				"country": "US",
				"state": "Kentucky"
			}
		]
	"""
	
	func modelWithResource(_ resource: Resource) -> RepoResource.Model? {
		resource.modelWithJSONData(convertJSONToData(item: json)!)
	}
}

extension NetworkJSONModelRepoResource {
	func obtainModel() -> Model {
		NetworkJSONModelRepository().modelWithResource(self)!
	}
}
