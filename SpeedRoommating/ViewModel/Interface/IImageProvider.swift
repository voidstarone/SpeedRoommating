//
//  ImageCache.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 20/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit


protocol IImageProvider {
    func requestImage(atUrl imageUrl: URL, onComplete: @escaping (Result<UIImage?, Error>) -> Void)
    func deleteCache(onComplete: @escaping () -> Void)
}
