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
	
	/// Example of SOLID `Liskov substitution` principle in all implementing protocols / concrete types
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

extension NetworkJSONModelResource {
	func obtainModel() -> Model {
		NetworkJSONModelRepository().modelWithResource(self)!
	}
}

struct LatLonResource: NetworkJSONModelResource {
	typealias Model = LatLon
	
	let locationName: String

	var url: URL? {
		URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(locationName)&limit=5&appid=\(Network.apiKey)")
	}
}

struct MockLatLonResource: NetworkJSONModelResource {
	typealias Model = LatLon
	
	var url: URL?
	
	func obtainModel() -> LatLon {
		LatLon(lat: 1, lon: 1)
	}
}


struct DailyResource: NetworkJSONModelResource {
	typealias Model = [DailyForecast]

	let latLon: LatLon?

	var url: URL? {
		guard let lat = latLon?.lat, let lon = latLon?.lon else { return nil }
		return URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(Network.apiKey)")
	}
}

struct MockDailyResource: NetworkJSONModelResource {
	typealias Model = [DailyForecast]
	
	var url: URL?
	
	func obtainModel() -> [DailyForecast] {
		[DailyForecast(minTemp: 12, maxTemp: 13)]
	}
}


/// By templating not only the resource but the repository, we have really concise & readable code in our
/// viewModel which can be very easily mocked as the resources themselves are so easy to setup.
/// The other nice thing about this is it's very flexible, requiring minimal code changes if we wanted, for
/// example, to replace the source of our models as we use an identical interface for all resources types.
/// So if we wanted to replace a back end service with a baked in store or maybe one that is created
/// having been fetched on startup, then no code changes are required in our code at this level.
///
/// SOLID `Dependancy inversion` principle kinda...
class LocationSummaryViewModel {
	let latLonResource: any Resource
	let dailyResource: any Resource
	
	var latLon: LatLon?
	
	init(latLonResource: any Resource = LatLonResource(locationName: "London"),
			 dailyResource: any Resource = DailyResource(latLon: nil)
	) {
		self.latLonResource = latLonResource
		self.dailyResource = dailyResource
	}
	
	func fetchLatLon() {
		latLon = latLonResource.obtainModel() as? LatLon
	}
	
	func daily() -> [DailyForecast]? {
		dailyResource.obtainModel() as? [DailyForecast]
	}
}




class NetworkJSONModelRepository<Resource: NetworkJSONModelResource>: Repository {
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
		try! JSONDecoder().decode(Resource.Model.self, from: convertJSONToData(item: json)!)
	}
}
