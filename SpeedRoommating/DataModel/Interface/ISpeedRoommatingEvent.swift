//
//  SpeedRoommatingEvent.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 21/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation

public protocol ISpeedRoommatingEvent {
    var imageName: String { get }
    var cost: String { get }
    var location: String  { get }
    var venue: String { get }
    var startTime: Date { get }
    var endTime: Date { get }
}
