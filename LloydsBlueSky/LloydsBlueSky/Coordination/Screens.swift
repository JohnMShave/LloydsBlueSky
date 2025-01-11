//
//  ViewAndNavigationTypes.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

enum Screen: Hashable {
	case locationSummary
	case daily
	
	func viewType() -> AnyView {
		switch self {
		case .locationSummary: AnyView(LocationSummaryView())
		case .daily: AnyView(DailyView())
		}
	}
}

enum FullScreenCover: Identifiable {
	case hourly
	
	func viewType() -> AnyView {
		switch self {
		case .hourly: AnyView(HourlyView())
		}
	}
	
	var id: String {
		switch self {
			case .hourly: return "hourly"
		}
	}
}

enum Sheet: Identifiable {
	case searchResults
	
	func viewType() -> AnyView {
		switch self {
		case .searchResults: AnyView(SearchResultsView())
		}
	}
	
	var id: String {
		switch self {
		case .searchResults: return "searchResults"
		}
	}
}
