//
//  ViewableEventTests.swift
//  SpeedRoommatingTests
//
//  Created by Thomas Lee on 23/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation

import Foundation
import XCTest
@testable import SpeedRoommating

class ViewableEventTests: XCTestCase {
    
    var eventToDecorate: ISpeedRoommatingEvent! = nil
    var viewableEvent: IViewableEvent! = nil
    let formatter = DateFormatter()
    
    override func setUp() {
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
    }

    override func tearDown() {
        
    }
    
    private func getUrlComponents(from url: URL) -> [String:Any] {
        if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let host = urlComponents.host,
            let queryItems = urlComponents.queryItems {
            var queryItemMap = [String:String]()
            for queryItem in queryItems {
                queryItemMap[queryItem.name] = queryItem.value
            }
            return [
                "host": host,
                "path": urlComponents.path,
                "queryItems": queryItemMap
            ]
        }
        return [:]
    }
    
    func testImageUrlAtSize() {
        eventToDecorate = SpeedRoommatingEvent(imageName: "8899",
                                                cost: "paid",
                                                location: "moon",
                                                venue: "the mars bar",
                                                startTime: formatter.date(from: "2021-06-01 19:00")!,
                                                endTime: formatter.date(from: "2021-06-01 20:30")!)
        viewableEvent = ViewableEvent(event: eventToDecorate)
        
        let imageUrl800x600 = viewableEvent.imageUrlAt(size: CGSize(width: 800, height: 600))
        
        //This nonsense is necessary because they might change the version number in the URL
        let urlParts = getUrlComponents(from: imageUrl800x600)
        let queryItems = urlParts["queryItems"] as! [String: String]

        XCTAssertEqual(urlParts["path"] as! String, "/8899")
        XCTAssertEqual(queryItems["h"]!, "600")
        XCTAssertEqual(queryItems["w"]!, "800")
        XCTAssertEqual(queryItems["fit"]!, "crop")
    }

    func testDurationTextNormal() {
        eventToDecorate = SpeedRoommatingEvent(imageName: "8899",
                                                cost: "paid",
                                                location: "moon",
                                                venue: "the mars bar",
                                                startTime: formatter.date(from: "2021-06-01 19:00")!,
                                                endTime: formatter.date(from: "2021-06-01 20:30")!)
        viewableEvent = ViewableEvent(event: eventToDecorate)
        
        let durationText = viewableEvent.durationText
        
        XCTAssertEqual(durationText, "7 — 8:30 PM")
    }
    
    func testDurationTextSplitOverMorningAndAfternoon() {
        eventToDecorate = SpeedRoommatingEvent(imageName: "8899",
                                                cost: "paid",
                                                location: "moon",
                                                venue: "the mars bar",
                                                startTime: formatter.date(from: "2021-06-01 11:00")!,
                                                endTime: formatter.date(from: "2021-06-01 13:30")!)
        viewableEvent = ViewableEvent(event: eventToDecorate)
        
        let durationText = viewableEvent.durationText
        
        XCTAssertEqual(durationText, "11 AM — 1:30 PM")
    }
    
    func testDurationTextBothHaveMinutesAndSplitOverMorningAndAfternoon() {
        eventToDecorate = SpeedRoommatingEvent(imageName: "8899",
                                                cost: "paid",
                                                location: "moon",
                                                venue: "the mars bar",
                                                startTime: formatter.date(from: "2021-06-01 11:30")!,
                                                endTime: formatter.date(from: "2021-06-01 13:30")!)
        viewableEvent = ViewableEvent(event: eventToDecorate)
        
        let durationText = viewableEvent.durationText
        
        XCTAssertEqual(durationText, "11:30 AM — 1:30 PM")
    }
    
    func testDurationTextBothHaveMinutesInMorning() {
        eventToDecorate = SpeedRoommatingEvent(imageName: "8899",
                                                cost: "paid",
                                                location: "moon",
                                                venue: "the mars bar",
                                                startTime: formatter.date(from: "2021-06-01 10:30")!,
                                                endTime: formatter.date(from: "2021-06-01 11:30")!)
        viewableEvent = ViewableEvent(event: eventToDecorate)
        
        let durationText = viewableEvent.durationText
        
        XCTAssertEqual(durationText, "10:30 — 11:30 AM")
    }
    
    // Considering adding a special case for this; but probably not worth it.
    func testDurationTextBothTimesIdentical() {
        eventToDecorate = SpeedRoommatingEvent(imageName: "8899",
                                                cost: "paid",
                                                location: "moon",
                                                venue: "the mars bar",
                                                startTime: formatter.date(from: "2021-06-01 10:30")!,
                                                endTime: formatter.date(from: "2021-06-01 10:30")!)
        viewableEvent = ViewableEvent(event: eventToDecorate)
        
        let durationText = viewableEvent.durationText
        
        XCTAssertEqual(durationText, "10:30 — 10:30 AM")
    }
}
