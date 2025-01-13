//
//  RepoResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

protocol RepoResource {
	associatedtype Model
	
	func obtainModel() -> Model
}

protocol JSONModelRepoResource: RepoResource where Model: Decodable {
	func modelWithJSONData(_ json: Data) -> Model?
}

extension JSONModelRepoResource {
	func modelWithJSONData(_ jsonData: Data) -> Model? {
		try? JSONDecoder().decode(Model.self, from: jsonData)
	}
}

protocol NetworkResource {
	var url: URL? { get }
	
	/// With more time I would add the following and build the URLs accordingly inside implementing Resource types -
	/// var requestMethod (`.get`, `.put` etc)
	/// var headerFields[String: String]
	/// var queryItems: [URLQueryItem]?
}

protocol NetworkJSONModelRepoResource: NetworkResource, JSONModelRepoResource {}
