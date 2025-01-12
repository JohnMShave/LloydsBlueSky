//
//  PageType.swift
//  LloydsBlueSky
//
//  Created by John Shave on 12/01/2025.
//

import SwiftUI

/// Whilst I prefer to handle view creation in the Coordinator as it's also torn down there, I want the
/// following PageType to be responsible for supplying the viewType - done using type erasure.
///
/// This decouples Coordinator and the PageType giving the following advantages -
///
///	1) We don't want people messing in Coordinator code. This code is nicely isolated and simple
///	to use without future devs needing to dig around in the Coordinator.
///
///	2) The navigation structure can more easily be data driven with this isolation - this could easily
///	be data driven e.g. generated from a .yml for example.
///
///	3) Coordinator doesn't have to know about different View types / is decoupled from them.
///
///	4) It's less error prone since the 1-1 nature of the Page's type and the View's type is encapsulated.

enum PageType: Identifiable, Hashable {
	case locationSummary
	case daily
	case hourly(day: String)
	case searchResults
	
	func viewType() -> AnyView {
		switch self {
		case .locationSummary:
			AnyView(LocationSummaryView())
		case .daily:
			AnyView(DailyView())
		case .hourly(let dayName):
			AnyView(HourlyView(dayName: dayName))
		case .searchResults:
			AnyView(SearchResultsView())
		}
	}
	
	var id: String {
		switch self {
		case .locationSummary: "locationSummary"
		case .daily: "daily"
		case .hourly: "hourly"
		case .searchResults: "searchResults"
		}
	}
}
