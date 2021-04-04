//
//  SpeedRoommatingUITests.swift
//  SpeedRoommatingUITests
//
//  Created by Thomas Lee on 18/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import XCTest

class SpeedRoommatingUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArchivedTabExists() {
        let app = XCUIApplication()
        app.launch()
        let upcomingTab = app.buttons["main_tab_archived"]

        if upcomingTab.waitForExistence(timeout: 1) {
            upcomingTab.tap()
        }
        XCTAssertEqual(upcomingTab.exists, true)
    }
    
    func testTabbingWorks() {
        let app = XCUIApplication()
        app.launch()
        let optionsTab = app.buttons["main_tab_options"]
        XCTAssertEqual(app.staticTexts["screen_options_title"].isHittable, false)
        if optionsTab.waitForExistence(timeout: 1) {
            optionsTab.tap()
        }
        sleep(1)
        XCTAssertEqual(app.staticTexts["screen_options_title"].isHittable, true)
    }
    
    func testEventLoadingWorks() {
        let app = XCUIApplication()
        app.launch()
        let knownEventHeader = app.staticTexts["table_header_april"]
        
        XCTAssertEqual(knownEventHeader.exists, false)
        sleep(3)
        XCTAssertEqual(knownEventHeader.exists, true)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
