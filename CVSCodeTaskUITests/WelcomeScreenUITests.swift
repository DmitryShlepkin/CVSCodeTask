//
//  WelcomeScreenUITests.swift
//  WelcomeScreenUITests
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import XCTest

final class WelcomeScreenUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testWelcomeScreenTitle() throws {
        let app = XCUIApplication()
        app.launch()
        let suggestedDynamicsTitleText = app.staticTexts["Welcome!"]
        XCTAssertTrue(suggestedDynamicsTitleText.exists)
    }
    
    @MainActor
    func testWelcomeScreenDescription() throws {
        let app = XCUIApplication()
        app.launch()
        let suggestedDynamicsTitleText = app.staticTexts["Please enter search keywords above."]
        XCTAssertTrue(suggestedDynamicsTitleText.exists)
    }

}
