//
//  NetworkJSONModelRepository.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

class NetworkJSONModelRepository<Resource: NetworkJSONModelRepoResource>: Repository {
	typealias RepoResource = Resource
	
	private let session = URLSession.shared
	
	func modelWithResource(_ resource: Resource) async throws -> RepoResource.Model {
		guard let request = resource.request else { throw NetworkError.invalidURL }
		
		guard let (data, response) = try await session.data(for: request) as? (Data, HTTPURLResponse),
					response.isValid
		else {
			throw NetworkError.networkError
		}
		
		guard let model = resource.modelWithJSONData(data) else {
			throw NetworkError.invalidResponse
		}
		
		return model
	}
}

private extension HTTPURLResponse {
	var isValid: Bool { 200..<300 ~= statusCode }
}

//	func convertJSONToData<T: Encodable>(item: T) -> Data? {
//			do {
//					let encodedJSON = try JSONEncoder().encode(item)
//					return encodedJSON
//			} catch {
//					return nil
//			}
//	}
//
//	let json = """
//		[
//			{
//				"name": "London",
//				"lat": 37.1289771,
//				"lon": -84.0832646,
//				"country": "US",
//				"state": "Kentucky"
//			}
//		]
//	"""
//	resource.modelWithJSONData(convertJSONToData(item: json)!)
