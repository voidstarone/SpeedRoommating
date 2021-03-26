//
//  EventTableDataSourceTests.swift
//  SpeedRoommatingTests
//
//  Created by Thomas Lee on 24/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation

import XCTest
@testable import SpeedRoommating

class EventTableDataSourceTests: XCTestCase {
    
    var eventProvider: ISpeedRoommatingEventProvider = MockSpeedRoommatingEventProvider()
    var imageProvider: IImageProvider = MockImageProvider()
    
    override func setUp() {
        imageProvider = KingfisherImageProvider()
    }

    override func tearDown() {

        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStuff() {
        XCTAssertEqual(false, true)
    }
    
}
