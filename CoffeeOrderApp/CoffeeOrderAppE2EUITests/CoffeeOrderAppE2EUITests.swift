//
//  CoffeeOrderAppE2EUITests.swift
//  CoffeeOrderAppE2EUITests
//
//  Created by AppleD0g on 3/12/25.
//

import XCTest

final class when_app_is_launched_with_no_order: XCTestCase {


    func test_should_make_sure_no_orders_message_is_displayed() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        XCTAssertEqual("No orders avaliable", app.staticTexts["NoOrderText"].label)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
