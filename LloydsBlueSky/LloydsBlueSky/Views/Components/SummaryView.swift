//
//  SummaryView.swift
//  LloydsBlueSky
//
//  Created by John Shave on 11/01/2025.
//

import SwiftUI

struct SummaryView: View {
	
	let title: String
	let tempHigh: Int
	let tempLow: Int
	
	var body: some View {
		HStack {
			Spacer()
			Text("\(title)")
				.font(.title2)
			Spacer()
			VStack {
				Text("High")
					.font(.title3)
				Text("\(tempHigh)")
					.font(.title)
			}
			Spacer()
			VStack {
				Text("Low")
					.font(.title3)
				Text("\(tempLow)")
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
