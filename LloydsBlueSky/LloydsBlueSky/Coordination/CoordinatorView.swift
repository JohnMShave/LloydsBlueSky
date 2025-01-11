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
			coordinator.buildScreen(.locationSummary)
				.navigationDestination(for: Screen.self) { screen in
					coordinator.buildScreen(screen)
				}
				.sheet(item: $coordinator.sheet) { sheet in
					coordinator.buildSheet(sheet)
				}
				.fullScreenCover(item: $coordinator.fullScreenCover) { item in
					coordinator.buildFullScreenCover(item)
				}
		}
		.environmentObject(coordinator)
		.environmentObject(forecastContext)
	}
}
