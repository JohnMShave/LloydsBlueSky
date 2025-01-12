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
	@Published var cover: Page?
	@Published var sheet: Page?

	func popScreen() {
		navigationPath.removeLast()
	}
	
	func popToRootScreen() {
		navigationPath.removeLast(navigationPath.count)
	}
	
	func presentPage(_ pageType: PageType, withStyle style: PresentationStyle) {
		presentPage(.init(type: pageType, style: style))
	}
			
	func dismissSheet() {
		sheet = nil
	}
		
	func dismissCover() {
		cover = nil
	}
	
	@ViewBuilder
	func buildScreenWithPageType(_ pageType: PageType) -> some View {
		pageType.viewType()
	}
	
	@ViewBuilder
	func buildSheetWithPageType(_ pageType: PageType) -> some View {
		pageType.viewType()
	}
	
	@ViewBuilder
	func buildCoverWithPageType(_ pageType: PageType) -> some View {
		pageType.viewType()
	}
	
	private func presentPage(_ page: Page) {
		switch page.style {
		case .screen:
			pushScreen(page.type)
		case .cover:
			cover = page
		case .sheet:
			sheet = page
		}
	}
	
	private func pushScreen(_ page: PageType) {
		navigationPath.append(page)
	}
}

extension Coordinator {	
	struct Page: Hashable, Identifiable {
		var type: PageType
		var style: PresentationStyle
		
		var id: String { type.id }
	}
}

extension PageType: Identifiable {
	var id: String { rawValue }
}

enum PresentationStyle: Hashable {
	case screen, cover, sheet
}
