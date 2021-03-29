//
//  IEventTableDataSource.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 24/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

protocol IEventTableViewDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var imageProvider: IImageProvider { get set }
    var eventProvider: ISpeedRoommatingEventProvider { get set }
    var controlledTableView: UITableView! { get set }
    var whichEventsToShow: EventsToShow { get set }
    
    func fetchEventsFromEventProvider(onComplete: @escaping (Error?) -> Void)
}
