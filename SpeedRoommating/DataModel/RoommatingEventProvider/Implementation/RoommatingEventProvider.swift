//
//  RoommatingEventProvider.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 21/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import SpeedRoommatingEventRepository

enum RoommatingEventProviderError : Error {
    case notPreloaded
    case dealloc
}

class SpeedRoommatingEventProvider : ISpeedRoommatingEventProvider {

    var eventCache: [ISpeedRoommatingEvent]? = nil
    var cacheLastUpdatedAt: Date? = nil
    private let eventRepo = SpeedRoommatingEventRepo.default
    
    public func preloadEventsOnOrAfter(date: Date, onComplete: @escaping (Error?) -> Void) {
        eventRepo.listAllEventsOnOrAfter(date: date) {
            [weak self] result in
            switch(result) {
            case let .failure(error):
                onComplete(error)
                return
            case let .success(events):
                self?.eventCache = events.map {
                    eventDto in
                    // TODO: Abstract to factory
                    let newEvent = SpeedRoommatingEvent(imageName: URL(string: eventDto.imageUrl)?.lastPathComponent ?? "",
                                                        cost: eventDto.cost,
                                                        location:eventDto.location,
                                                        venue: eventDto.venue,
                                                        startTime: eventDto.startTime,
                                                        endTime: eventDto.endTime)
                
                    return newEvent
                }
                onComplete(nil)
            }
        }
    }
    
    public func getEventsByYearAndMonth(onOrAfterDate date: Date, onComplete: @escaping (Result<[Int : [Int : [ISpeedRoommatingEvent]]], Error>) -> Void) {
        
        // This should be some timeout logic, but we both know these events aren't changing while we're looking at this app
        if cacheLastUpdatedAt == nil || self.eventCache == nil{
            preloadEventsOnOrAfter(date: date) {
                [weak self] error in
                if error != nil {
                    onComplete(.failure(error!))
                    return
                }
                if self == nil {
                    onComplete(.failure(RoommatingEventProviderError.dealloc))
                }
                let groupedEvents = self!.splitEventsIntoYearsAndMonths(events: self!.eventCache!)
                onComplete(.success(groupedEvents))
            }
        }
    }
    
    public func deleteCache() {
        self.cacheLastUpdatedAt = nil
        self.eventCache = nil
    }
    
    private func splitEventsIntoYearsAndMonths(events allEvents: [ISpeedRoommatingEvent])
        -> [Int: [Int: [ISpeedRoommatingEvent]]] {
        let yearsEvents = splitEventsIntoYears(events: allEvents)
        let yearsAndMonthsEvents = splitYearsEventsIntoMonths(yearsEvents: yearsEvents)
        return yearsAndMonthsEvents
    }
    
    private func splitEventsIntoYears(events allEvents: [ISpeedRoommatingEvent])
        -> [Int: [ISpeedRoommatingEvent]] {
            var yearDict: [Int: [ISpeedRoommatingEvent]] = [:]
            allEvents.forEach {
                event in
                let thisYear = Calendar.current.dateComponents([.year], from: event.startTime).year!
                if yearDict[thisYear] == nil {
                    yearDict[thisYear] = []
                }
                yearDict[thisYear]!.append(event)
            }
            return yearDict
    }
    
    private func splitYearsEventsIntoMonths(yearsEvents: [Int: [ISpeedRoommatingEvent]])
        -> [Int: [Int: [ISpeedRoommatingEvent]]] {
        var newYearsDicts: [Int : [Int : [ISpeedRoommatingEvent]]] = [:]
        yearsEvents.forEach {
            yearDict in
            let eventsThisYear = yearDict.value
            let thisYear = yearDict.key
            var newYearDicts: [Int: [ISpeedRoommatingEvent]] = [:]
            eventsThisYear.forEach {
                event in
                let thisMonth = Calendar.current.dateComponents([.month], from: event.startTime).month!
                if newYearDicts[thisMonth] == nil {
                    newYearDicts[thisMonth] = []
                }
                newYearDicts[thisMonth]?.append(event)
            }
            newYearsDicts[thisYear] = newYearDicts
        }
        return newYearsDicts
    }
}
