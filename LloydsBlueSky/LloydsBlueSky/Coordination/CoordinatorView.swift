//
//  CoordinatorView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

struct CoordinatorView: View {
	@StateObject private var coordinator = Coordinator()
	@StateObject private var forecastContext = ForecastContext()
	
	var body: some View {
		NavigationStack(path: $coordinator.navigationPath) {
			coordinator.buildScreenWithPageType(PageType.locationSummary)
				.navigationDestination(for: PageType.self) { type in
					coordinator.buildScreenWithPageType(type)
				}
				.sheet(item: $coordinator.sheet) { sheet in
					coordinator.buildSheetWithPageType(sheet.type)
				}
				.fullScreenCover(item: $coordinator.cover) { cover in
					coordinator.buildCoverWithPageType(cover.type)
				}
		}
		.environmentObject(coordinator)
		.environmentObject(forecastContext)
	}
}
