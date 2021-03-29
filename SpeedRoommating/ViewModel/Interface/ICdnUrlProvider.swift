//
//  CDNPathProvider.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 23/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

protocol ICdnUrlProvider {
    func pathForImage(named: String, atSize: CGSize) -> URL
}
