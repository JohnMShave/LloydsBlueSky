//
//  LloydsBlueSkyUITests.swift
//  LloydsBlueSkyUITests
//
//  Created by John Shave on 08/01/2025.
//

import XCTest

final class LloydsBlueSkyUITests: XCTestCase {
	
	let app = XCUIApplication()
	
	override func setUpWithError() throws {
		continueAfterFailure = false
		app.launchArguments.append("UITEST")
		app.launch()
	}
	
	override func tearDownWithError() throws {
	}
	
	func test_locationSummaryView_dailyButtonNavigatesToDailyView() throws {
		XCTAssert(app.staticTexts["locationsummary.text.locationname"].waitForExistence(timeout: 5))
		let locationName = app.staticTexts["locationsummary.text.locationname"]
		XCTAssertEqual(locationName.label, "Bristol")
	}
	
	func test_wordDefinitionView_displaysDefinition() throws {
		XCTAssert(app.buttons["locationsummary.dailybutton"].waitForExistence(timeout: 5))
		app.buttons["locationsummary.dailybutton"].tap()
		
		XCTAssert(app.staticTexts["daily.text.locationName"].waitForExistence(timeout: 5))
		let locationName = app.staticTexts["daily.text.locationName"]
		XCTAssertEqual(locationName.label, "Bristol")
	}
}
