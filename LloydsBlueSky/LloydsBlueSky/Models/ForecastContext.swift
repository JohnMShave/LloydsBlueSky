//
//  ForecastContext.swift
//  LloydsBlueSky
//
//  Created by John Shave on 12/01/2025.
//

import Foundation

class ForecastContext: ObservableObject {
	@Published var locationName: String = "Bristol"
	@Published var locationCoords: LatLon?
}
