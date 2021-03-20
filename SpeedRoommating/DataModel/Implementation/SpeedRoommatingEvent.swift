//
//  SpeedRoommatingEvent.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 21/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation

public struct SpeedRoommatingEvent : ISpeedRoommatingEvent {
    public var imageName: String
    public var cost: String
    public var location: String
    public var venue: String
    public var startTime: Date
    public var endTime: Date
}
