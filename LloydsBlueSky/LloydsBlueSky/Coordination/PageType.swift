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
	
	/// We could just make PageType a String enum and use rawValue here but we would also need to
	/// add an optional dayName to our ForecastContext structure a. That would kinda make sense for
	/// that particular use case but chances are in a less contrived, real world example you'd need the
	/// ability to inject various other types into the different pages that wouldn't really make sense in
	/// the forecastContext and more generally in other flows that had different contexts.
	/// Nearly always regret constraining an enum to a type like String or Int unless it's very basic.
	/// Associated types provide so much more power with enums and the desired respective String or
	/// Int or whatever can always be added trivially, as below.
	var id: String {
		switch self {
		case .locationSummary: "locationSummary"
		case .daily: "daily"
		case .hourly: "hourly"
		case .searchResults: "searchResults"
		}
	}
}
