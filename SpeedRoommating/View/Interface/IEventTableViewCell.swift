//
//  IEventTableViewCell.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 26/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

protocol IEventTableViewCell : UITableViewCell {
    var backgroundImageView: UIImageView! {get set}
    var costLabel: TransluscentRoundedLabel! {get set}
    var dateLabel: UILabel! {get set}
    var timeLabel: UILabel! {get set}
    var locationLabel: UILabel! {get set}
    var venueLabel: UILabel! {get set}
}
