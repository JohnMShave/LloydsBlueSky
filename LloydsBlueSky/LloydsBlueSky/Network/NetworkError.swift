//
//  NetworkError.swift
//  LloydsBlueSky
//
//  Created by John Shave on 13/01/2025.
//

import Foundation

enum NetworkError: Error {//}, Equatable {
	case invalidURL
	case networkError
	case invalidResponse
	case unexpectedError(message: String)
}

extension NetworkError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			"Invalid URL."
		case .networkError:
			"General network error"
		case .invalidResponse:
			"Invalid server response"
		case .unexpectedError(let message):
			"Unknown error:\n\n\(message)"
		}
	}
}
