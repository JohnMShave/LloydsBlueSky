//
//  PageType.swift
//  LloydsBlueSky
//
//  Created by John Shave on 12/01/2025.
//

import SwiftUI

/// Prefer handle view generation in the Coordinator e.g. with it doing switches on PageType.
///	a) We don't want people messing in Coordinator code. This code is nicely isolated and simple.
///	b) Navigation structure can more easily be data driven with this isolation
///	c) Coordinator doesn't have to know about different View types / is decoupled from them
///	d) This feels less error prone and I think, if the view type is 1-1 with the View then that relationship
///	should be encapsulated in one place without something else deciding what type of view to create.

enum PageType: String {
	case locationSummary
	case daily
	case hourly
	case searchResults
	
	func viewType() -> AnyView {
		switch self {
		case .locationSummary: AnyView(LocationSummaryView())
		case .daily: AnyView(DailyView())
		case .hourly: AnyView(HourlyView())
		case .searchResults: AnyView(SearchResultsView())
		}
	}
}
