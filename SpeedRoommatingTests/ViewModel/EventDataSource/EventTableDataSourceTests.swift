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
        eventTableDataSource.controlledTableView = tableView
        
        tableView.delegate = eventTableDataSource
        tableView.dataSource = eventTableDataSource
        
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventTableViewCell")
    }
    
    override func tearDown() {
        eventTableDataSource = nil
        tableView = nil
    }
    
    func testFutureNumberOfSections() {
        let promiseToFetchEvents = expectation(description: "fetch events")
        
        eventTableDataSource.fetchEventsFromEventProvider {
            _ in
            let numSections = self.eventTableDataSource.numberOfSections?(in: self.tableView)
            XCTAssertEqual(numSections, 3)
            promiseToFetchEvents.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFutureNumberOfSectionsRowsInSection() {
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
    
    func testFutureGetHeader() {
        let promiseToFetchEvents = expectation(description: "fetch events")
                
        eventTableDataSource.fetchEventsFromEventProvider {
            _ in
            DispatchQueue.main.async {
                let firstHeader = self.eventTableDataSource.tableView?(self.tableView, viewForHeaderInSection: 0) as! EventTableHeaderView
                        
                XCTAssertEqual(firstHeader.headerLabel.text, "November")
                promiseToFetchEvents.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFutureGetRow() {
        let promiseToFetchEvents = expectation(description: "fetch events")
        
        let indexPath0_0 = IndexPath(row: 0, section: 0)
        
        eventTableDataSource.fetchEventsFromEventProvider {
            _ in
            DispatchQueue.main.async {
                let cellFor0_0 = self.eventTableDataSource.tableView(self.tableView, cellForRowAt: indexPath0_0) as! IEventTableViewCell
                
                DispatchQueue.main.async {
                    XCTAssertEqual(cellFor0_0.locationLabel.text, "Russia")
                    XCTAssertEqual(cellFor0_0.venueLabel.text, "Winter Palace")
                    promiseToFetchEvents.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testPastNumberOfSectionsRowsInSection() {
        let promiseToFetchEvents = expectation(description: "fetch events")
        eventTableDataSource.whichEventsToShow = .past
        eventTableDataSource.fetchEventsFromEventProvider {
            _ in
            DispatchQueue.main.async {
                let numRows0 = self.eventTableDataSource.tableView(self.tableView,
                                                                   numberOfRowsInSection: 0)
                XCTAssertEqual(numRows0, 1)
                
                let numRows1 = self.eventTableDataSource.tableView(self.tableView,
                                                                   numberOfRowsInSection: 1)
                XCTAssertEqual(numRows1, 1)
                
                let numRows2 = self.eventTableDataSource.tableView(self.tableView,
                                                                   numberOfRowsInSection: 2)
                XCTAssertEqual(numRows2, 2)
                
                promiseToFetchEvents.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
