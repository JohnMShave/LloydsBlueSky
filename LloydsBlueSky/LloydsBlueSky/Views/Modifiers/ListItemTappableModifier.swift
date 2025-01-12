//
//  ListItemTappableModifier.swift
//  LloydsBlueSky
//
//  Created by John Shave on 12/01/2025.
//

import SwiftUI

struct ListItemTappableModifier: ViewModifier {
	enum Alignment {
		case left
		case right
		case center
	}
	
	var alignment: Alignment
	var tapAction: (() -> Void)?
	
	init(alignment: Alignment = .left, tapAction: (() -> Void)? = nil) {
		self.alignment = alignment
		self.tapAction = tapAction
	}
	
	func body(content: Content) -> some View {
		HStack {
			if alignment == .right || alignment == .center {
				Spacer()
			}
			content
			if alignment == .left || alignment == .center {
				Spacer()
			}
		}
		.contentShape(Rectangle())
		.onTapGesture {
			tapAction?()
		}
	}
}

extension View {
	func listItemTapable(
		alignment: ListItemTappableModifier.Alignment = .left,
		tapAction: (() -> Void)? = nil
	) -> some View {
		modifier(ListItemTappableModifier(alignment: alignment, tapAction: tapAction))
	}
}
