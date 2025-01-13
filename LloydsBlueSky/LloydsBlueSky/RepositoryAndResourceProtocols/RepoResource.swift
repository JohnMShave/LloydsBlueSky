//
//  RepoResource.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

protocol RepoResource {
	associatedtype Model
	
	func obtainModel() async throws -> Model
}

protocol JSONModelRepoResource: RepoResource where Model: Decodable {
	func modelWithJSONData(_ json: Data) -> Model?
}

extension JSONModelRepoResource {
	func modelWithJSONData(_ jsonData: Data) -> Model? {
		try? JSONDecoder().decode(Model.self, from: jsonData)
	}
}
