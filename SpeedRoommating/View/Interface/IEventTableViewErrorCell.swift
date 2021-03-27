
//
//  IEventTableViewErrorCell.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 27/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

protocol IEventTableViewErrorCell : UITableViewCell {
    var rowHeight: CGFloat { get }
    func setImage(_ image: UIImage, title: String, description: String)
    func setButton(text: String, callback:  @escaping () -> Void)
}
