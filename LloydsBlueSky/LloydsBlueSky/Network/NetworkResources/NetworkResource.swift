//
//  NetworkResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

protocol NetworkResource {
	var url: URL? { get }
	
	/// With more time I would add the following and build the URLs accordingly inside implementing Resource types -
	/// var requestMethod (`.get`, `.put` etc)
	/// var headerFields[String: String]
	/// var queryItems: [URLQueryItem]?
}

protocol NetworkJSONModelRepoResource: NetworkResource, JSONModelRepoResource {}

extension NetworkJSONModelRepoResource {
	func obtainModel() -> Model {
		NetworkJSONModelRepository().modelWithResource(self)!
	}
}



