//
//  FetchState.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

enum FetchState<Model: Equatable>: Equatable {
	case idle
	case fetching(resource: any RepoResource)
	case fetched(resource: any RepoResource, model: Model)
	case failed(resource: any RepoResource, error: any Error)
	
	static func ==(lhs: FetchState, rhs: FetchState) -> Bool {
		switch (lhs, rhs) {
		case (.fetching, .fetching), (.failed, .failed):
			return true
		case (let .fetched(_, modelLhs), let .fetched(_, modelRhs)):
			return modelLhs == modelRhs
		default:
			return false
		}
	}
	
	var model: Model? {
		switch self {
		case .fetched(resource: let resource, model: let model):
			return model
		default:
			return nil
		}
	}
}
