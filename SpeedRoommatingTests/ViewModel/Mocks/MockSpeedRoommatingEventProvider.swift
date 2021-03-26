//
//  MockSpeedRoommatingEventProvider.swift
//  SpeedRoommatingTests
//
//  Created by Thomas Lee on 26/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
@testable import SpeedRoommating

struct MockSpeedRoommatingEventProvider : ISpeedRoommatingEventProvider {
    mutating func preloadEventsOnOrAfter(date: Date, onComplete: @escaping (Error?) -> Void) {
        
    }
    
    mutating func getEventsByYearAndMonth(onOrAfterDate date: Date, onComplete: @escaping (Result<[Int : [Int : [ISpeedRoommatingEvent]]], Error>) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let eventsByYearAndMonth: [Int : [Int : [ISpeedRoommatingEvent]]] =
            [1917:
                [
                    11: [
                        SpeedRoommatingEvent(imageName: "photo-1525268323446-0505b6fe7778",
                                             cost: "free",
                                             location: "Russia",
                                             venue: "Winter Palace",
                                             startTime: formatter.date(from: "1917-11-07 12:00")!,
                                             endTime: formatter.date(from: "1917-11-07 19:00")!),
                        SpeedRoommatingEvent(imageName: "photo-1525268323446-0505b6fe7778",
                                             cost: "paid",
                                             location: "Germany",
                                             venue: "Peace Palace",
                                             startTime: formatter.date(from: "1917-11-28 12:30")!,
                                             endTime: formatter.date(from: "1917-11-28 19:30")!)
                    ],
                    12: [
                        SpeedRoommatingEvent(imageName: "photo-1525268323446-0505b6fe7778",
                                             cost: "free",
                                             location: "Finland",
                                             venue: "Government Palace",
                                             startTime: formatter.date(from: "1917-12-06 12:00")!,
                                             endTime: formatter.date(from: "1917-12-06 12:00")!),
                    ]
                ],
             1918: [
                11: [
                SpeedRoommatingEvent(imageName: "photo-1525268323446-0505b6fe7778",
                                     cost: "free",
                                     location: "Germany",
                                     venue: "Kiel ships",
                                     startTime: formatter.date(from: "1918-11-03 10:00")!,
                                     endTime: formatter.date(from: "1918-11-03 23:00")!)
                ]
            ]
        ]
        
        onComplete(.success(eventsByYearAndMonth))
    }
    
    mutating func deleteCache() {
        
    }
    
    
    
    
}
