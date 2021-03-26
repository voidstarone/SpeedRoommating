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
    
    var mockEventProvider: ISpeedRoommatingEventProvider = MockSpeedRoommatingEventProvider()
    var mockImageProvider: IImageProvider = MockImageProvider()
    
    var eventTableDataSource: IEventTableViewDataSource!
    var tableView: UITableView!
    
    override func setUp() {
        tableView = UITableView()
        
        eventTableDataSource = EventTableViewDataSource()
        eventTableDataSource.imageProvider = mockImageProvider
        eventTableDataSource.eventProvider = mockEventProvider
    }

    override func tearDown() {

        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberOfSections() {
        let promiseToFetchEvents = expectation(description: "fetch rows")

        eventTableDataSource.fetchEventsFromEventProvider {
            _ in
            let numSections = self.eventTableDataSource.numberOfSections?(in: self.tableView)
            XCTAssertEqual(numSections, 3)
            promiseToFetchEvents.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testNumberOfSectionsRowsInSection() {
        let promiseToFetchEvents = expectation(description: "fetch events")
        eventTableDataSource.fetchEventsFromEventProvider {
            _ in
            let numRows0 = self.eventTableDataSource.tableView(self.tableView,
                                                              numberOfRowsInSection: 0)
            XCTAssertEqual(numRows0, 2)
            
            let numRows1 = self.eventTableDataSource.tableView(self.tableView,
                                                               numberOfRowsInSection: 1)
            
            XCTAssertEqual(numRows1, 1)
            
            let numRows2 = self.eventTableDataSource.tableView(self.tableView,
                                                               numberOfRowsInSection: 2)
            
            XCTAssertEqual(numRows2, 1)
            
            promiseToFetchEvents.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

    }
    
}
