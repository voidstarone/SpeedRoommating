//
//  IRoommatingEventSource.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 21/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation

protocol ISpeedRoommatingEventProvider {
    mutating func preloadEventsOnOrAfter(date: Date,
                                         onComplete: @escaping (Error?) -> Void)
    mutating func getEventsByYearAndMonth(onOrAfterDate date: Date,
                                          onComplete: @escaping (Result<[Int : [Int : [ISpeedRoommatingEvent]]], Error>) -> Void)
    mutating func getEventsByYearAndMonth(beforeDate date: Date,
                                          onComplete: @escaping (Result<[Int : [Int : [ISpeedRoommatingEvent]]], Error>) -> Void)
    mutating func deleteCache()
}
