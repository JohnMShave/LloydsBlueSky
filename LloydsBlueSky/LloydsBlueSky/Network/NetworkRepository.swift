//
//  NetworkRepository.swift
//  LloydsBlueSky
//
//  Created by John Shave on 09/01/2025.
//

enum RepoError: Error {
	case unexpectedError(message: String)
	case networkError(error: Network.SessionError)
}

class NetworkRepository<Resource: NetworkResource>: ModelRepository {
	var resource: (any NetworkResource)?
	
	func updateWithResource(_ resource: Resource) async throws -> Resource.Model? {
		self.resource = resource
		return try await updateModel()
	}
	
	func updateModel() async throws -> Resource.Model? {
		guard let resource else { return nil }
		
		do {
			return try await resource.useToFetchModel() as? Resource.Model
		} catch let error as Network.SessionError {
			throw RepoError.networkError(error: error)
		} catch {
			throw Network.SessionError.unexpectedError(message: error.localizedDescription)
		}
	}
}
