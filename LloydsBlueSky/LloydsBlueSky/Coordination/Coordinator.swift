//
//  Coordinator.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
	@Published var path: NavigationPath = NavigationPath()
	@Published var sheet: Sheet?
	@Published var fullScreenCover: FullScreenCover?
	
	func push(screen: Screen) {
		path.append(screen)
	}
	
	func pop() {
		path.removeLast()
	}
	
	func popToRoot() {
		path.removeLast(path.count)
	}
	
	func presentSheet(_ sheet: Sheet) {
		self.sheet = sheet
	}
	
	func presentFullScreenCover(_ cover: FullScreenCover) {
		self.fullScreenCover = cover
	}
	
	func dismissSheet() {
		self.sheet = nil
	}
	
	func dismissCover() {
		self.fullScreenCover = nil
	}
	
	@ViewBuilder
	func buildScreen(_ screen: Screen) -> some View {
		screen.viewType()
	}
	
	@ViewBuilder
	func buildSheet(sheet: Sheet) -> some View {
		sheet.viewType()
	}
	
	@ViewBuilder
	func buildFullScreenCover(_ cover: FullScreenCover) -> some View {
		cover.viewType()
	}
}
