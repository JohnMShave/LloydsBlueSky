//
//  NetworkResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

protocol NetworkResource {
	var url: URL? { get }
	var request: URLRequest? { get }

	/// With more time I would add the following and build the URLs accordingly inside implementing Resource types -
	/// var requestMethod (`.get`, `.put` etc)
	/// var headerFields[String: String]
	/// var queryItems: [URLQueryItem]?
}

extension NetworkResource {
	var request: URLRequest? {
		guard let url else { return nil }
		return URLRequest(url: url)
	}
}

protocol NetworkJSONModelRepoResource: NetworkResource, JSONModelRepoResource {}

extension NetworkJSONModelRepoResource {
	func obtainModel() async throws -> Model {
		do {
			return try await NetworkJSONModelRepository().modelWithResource(self)
		} catch {
			throw error
		}
	}
}



