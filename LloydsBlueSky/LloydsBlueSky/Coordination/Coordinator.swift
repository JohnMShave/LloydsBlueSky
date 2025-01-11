//
//  Coordinator.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
	@Published var navigationPath = NavigationPath()
	@Published var fullScreenCover: FullScreenCover?
	@Published var sheet: Sheet?
	
	func pushScreen(_ screen: Screen) {
		navigationPath.append(screen)
	}
	
	func popScreen() {
		navigationPath.removeLast()
	}
	
	func popToRootScreen() {
		navigationPath.removeLast(navigationPath.count)
	}
	
	func presentSheet(_ newSheet: Sheet) {
		sheet = newSheet
	}

	func dismissSheet() {
		sheet = nil
	}

	func presentFullScreenCover(_ cover: FullScreenCover) {
		fullScreenCover = cover
	}
		
	func dismissCover() {
		fullScreenCover = nil
	}
	
	@ViewBuilder
	func buildScreen(_ screen: Screen) -> some View {
		screen.viewType()
	}
	
	@ViewBuilder
	func buildSheet(_ sheet: Sheet) -> some View {
		sheet.viewType()
	}
	
	@ViewBuilder
	func buildFullScreenCover(_ cover: FullScreenCover) -> some View {
		cover.viewType()
	}
}
