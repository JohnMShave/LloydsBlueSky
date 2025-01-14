//
//  SummaryView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

struct SummaryView: View {
	
	let title: String
	let tempHigh: Double?
	let tempLow: Double?
	
	var tempHighText: String {
		guard let tempHigh else { return "-" }
		return "\(Int(tempHigh.rounded()))"
	}

	var tempLowText: String {
		guard let tempLow else { return "-" }
		return "\(Int(tempLow.rounded()))"
	}

	var body: some View {
		HStack {
			Spacer()
			Text("\(title)")
				.font(.title2)
			Spacer()
			VStack {
				Text("High")
					.font(.title3)
				Text(tempHighText)
					.font(.title)
			}
			Spacer()
			VStack {
				Text("Low")
					.font(.title3)
				Text(tempLowText)
					.font(.title)
			}
			Spacer()
		}
		.background(Color.secondary)
		.frame(maxWidth: .infinity)
		.cornerRadius(8)
		.padding(16)
	}
}
