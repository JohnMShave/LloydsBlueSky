//
//  LocationSummaryViewModelTests.swift
//  LloydsBlueSkyTests
//
//  Created by John Shave on 08/01/2025.
//

import XCTest
@testable import LloydsBlueSky

final class LocationSummaryViewModelTests: XCTestCase {
	
	override func setUpWithError() throws {
	}
	
	override func tearDownWithError() throws {
	}
	
	@MainActor
	func test_summaryIsCorrect_afterGetLatLon() async throws {
		let viewModel = LocationSummaryViewModel(
			latLonResource: MockLatLonResource(),
			forecastResource: MockForecastResource()
		)
		
		await viewModel.getLatLon()
		
		XCTAssertTrue(viewModel.summary.tempLow != nil)
		XCTAssertTrue(viewModel.summary.tempHigh != nil)
		XCTAssertTrue(fabs(viewModel.summary.tempLow! - 10.85) < 0.01)
		XCTAssertTrue(fabs(viewModel.summary.tempHigh! - 13.85) < 0.01)
	}

	@MainActor
	func test_summaryIsCorrect_afterGetForecast() async throws {
		let viewModel = LocationSummaryViewModel(
			latLonResource: MockLatLonResource(),
			forecastResource: MockForecastResource()
		)
		
		await viewModel.getLatLon()
		
		XCTAssertTrue(viewModel.summary.tempLow != nil)
		XCTAssertTrue(viewModel.summary.tempHigh != nil)
		XCTAssertTrue(fabs(viewModel.summary.tempLow! - 10.85) < 0.01)
		XCTAssertTrue(fabs(viewModel.summary.tempHigh! - 13.85) < 0.01)
	}

	@MainActor
	func test_latLonFetchStateIsFetched_afterGetLatLon() async throws {
		let viewModel = LocationSummaryViewModel(
			latLonResource: MockLatLonResource(),
			forecastResource: MockForecastResource()
		)
		
		await viewModel.getLatLon()
		
		switch viewModel.latLonFetchState {
		case .fetched:
			XCTAssertTrue(true)
			break
		default:
			XCTFail()
		}
	}
	
	@MainActor
	func test_forecastFetchStateIsFetched_afterGetForecast() async throws {
		let viewModel = LocationSummaryViewModel(
			latLonResource: MockLatLonResource(),
			forecastResource: MockForecastResource()
		)
		
		await viewModel.getLatLon()
		
		switch viewModel.forecastFetchState {
			case .fetched:
				XCTAssertTrue(true)
			break
			default:
				XCTFail()
		}
	}
}
