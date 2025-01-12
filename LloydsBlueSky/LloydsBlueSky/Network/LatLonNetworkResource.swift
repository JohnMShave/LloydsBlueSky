//
//  Untitled.swift
//  LloydsBlueSky
//
//  Created by John Shave on 09/01/2025.
//

import Foundation

protocol Repository {
	associatedtype RepoResource: Resource
	typealias Model = RepoResource.Model
	
	func modelWithResource(_ resource: RepoResource) -> Model?
}

protocol Resource {
	associatedtype Model
	
	func obtainModel() -> Model
}

protocol JSONModelResource: Resource where Model: Decodable {}

protocol NetworkResource {
	var url: URL? { get }
	
	/// With more time I would add the following and build the URLs accordingly inside implementing Resource types -
	/// var requestMethod (`.get`, `.put` etc)
	/// var headerFields[String: String]
	/// var queryItems: [URLQueryItem]?
}

protocol NetworkJSONModelResource: NetworkResource, JSONModelResource {}

struct LatLonResource: NetworkJSONModelResource {
	typealias Model = LatLon
	
	let locationName: String

	var url: URL? {
		URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(locationName)&limit=5&appid=\(Network.apiKey)")
	}

	func obtainModel() -> LatLon {
		NetworkJSONModelRepository.modelWithResource(self)!
	}
}

struct MockLatLonResource: NetworkJSONModelResource {
	typealias Model = LatLon
	
	var url: URL?
	
	func obtainModel() -> LatLon {
		LatLon(lat: 1, lon: 1)
	}
}



class ViewModel {
	let latLonResource: any NetworkJSONModelResource
	
	init(latLonResource: any NetworkJSONModelResource = LatLonResource(locationName: "London")) {
		self.latLonResource = latLonResource
	}
	
	func latLon() -> LatLon {
		latLonResource.obtainModel() as! LatLon
	}
}




class NetworkJSONModelRepository<Resource: NetworkJSONModelResource>: Repository {
	typealias RepoResource = Resource
	
	static func modelWithResource(_ resource: Resource) -> RepoResource.Model? {
		NetworkJSONModelRepository().modelWithResource(resource)
	}
	
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
		try! JSONDecoder().decode(Resource.Model.self, from: convertJSONToData(item: json)!)
	}
}
