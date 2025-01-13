//
//  Repository.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

protocol Repository {
	associatedtype Resource: RepoResource
	typealias Model = Resource.Model
	
	func modelWithResource(_ resource: Resource) -> Model?
}

