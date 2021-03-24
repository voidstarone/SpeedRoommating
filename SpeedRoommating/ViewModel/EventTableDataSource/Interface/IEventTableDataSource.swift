//
//  IEventTableDataSource.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 24/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

protocol IEventTableViewDataSource : NSObject, UITableViewDataSource {
    
    var imageProvider: IImageProvider { get set }
    var eventProvider: ISpeedRoommatingEventProvider { get set }
    var plainDataSource: UITableViewDataSource { get }
    
    func fetchEventsFromEventProvider(onComplete: @escaping (Error?) -> Void)
    
    
}
