//
//  IViewableEvent.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 23/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

protocol IViewableEvent {
    init(event: ISpeedRoommatingEvent)
    var cost: String  { get }
    var location: String  { get }
    var venue: String  { get }
    var durationText: String { get }
    var dateAsShortReadable: String { get }
    
    func imageUrlAt(size: CGSize) -> URL
}
