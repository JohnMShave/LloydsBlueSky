//
//  DailyViewModel.swift
//  LloydsBlueSky
//
//  Created by John Shave on 12/01/2025.
//

import Foundation

class DailyViewModel: ObservableObject {
	
	struct Day: Identifiable {
		let name: String
		var id = UUID()
	}

	var days: [Day] = []

	init() {
		days = [
			.init(name: "Monday"),
			.init(name: "Tuesday"),
			.init(name: "Wednesday"),
			.init(name: "Thursday"),
			.init(name: "Friday"),
			.init(name: "Saturday"),
			.init(name: "Sunday"),
		]
	}
}
