//
//  ViewableEvent.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 23/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

struct ViewableEvent : IViewableEvent {
   
    let cdnUrlProvider: ICdnUrlProvider = ImgxUrlProvider.default
    let calendar: Calendar = Calendar.current
    
    let cost: String
    let location: String
    let venue: String
    private var startTime: Date
    private var endTime: Date
    private let imageName: String
    
    var dateAsShortReadable: String {
        get {
            return dateAsXthOfMonth(date: startTime)
        }
    }
    
    var durationText: String {
        get {
            var durationString = ""
            
            let startTimeComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endTimeComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            
            let startTimeIsInAfternoon = timeIsPm(startTime)
            let endTimeIsInAfternoon = timeIsPm(endTime)
            let bothTimesAreInSameHalfOfDay = (
                (startTimeIsInAfternoon && endTimeIsInAfternoon) ||
                (!startTimeIsInAfternoon && !endTimeIsInAfternoon)
            )
            
            durationString = durationString + hourToString(startTimeComponents.hour!)
            if timeNeedsMinutes(startTime) {
                durationString = durationString + String(format: ":%02d", startTimeComponents.minute!)
            }
            if !bothTimesAreInSameHalfOfDay {
                durationString = durationString + " \(amOrPmFromHour(startTimeComponents.hour!))"
            }
            durationString = durationString + " — \(hourToString(endTimeComponents.hour!))"
            if timeNeedsMinutes(endTime) {
                durationString = durationString + String(format: ":%02d", endTimeComponents.minute!)
            }
            durationString = durationString + " \(amOrPmFromHour(endTimeComponents.hour!))"

            return durationString
        }
    }
    
    init(event: ISpeedRoommatingEvent){
        cost = event.cost
        location = event.location
        venue = event.venue
        imageName = event.imageName
        startTime = event.startTime
        endTime = event.endTime
    }
    
    func imageUrlAt(size: CGSize) -> URL {
        return cdnUrlProvider.pathForImage(named: imageName, atSize: size)
    }
    
    func dateAsXthOfMonth(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .ordinal
        
        let dayNumber = calendar.component(.day, from: startTime)
        let dayString = numFormatter.string(from: NSNumber(value: dayNumber))!
        let monthString = dateFormatter.string(from: startTime)
        
        return "\(dayString) \(monthString)"
    }
    
    private func timeNeedsMinutes(_ time: Date) -> Bool {
        let startTimeMinutes = calendar.component(.minute, from: time)
        return startTimeMinutes != 0
    }
    
    private func timeIsPm(_ time: Date) -> Bool {
        let hour = calendar.component(.hour, from: time)
        return hour >= 12
    }
    
    private func hourToString(_ hour: Int) -> String {
        if hour == 0 {
            return "12"
        }
        if hour >= 12 {
            return "\(hour - 12)"
        }
        return "\(hour)"
    }
    
    private func amOrPmFromHour(_ hour: Int) -> String {
        return hour >= 12 ? "PM" : "AM"
    }
}
