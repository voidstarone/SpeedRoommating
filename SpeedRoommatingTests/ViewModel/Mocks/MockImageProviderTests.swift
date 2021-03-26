//
//  MockImageProviderTests.swift
//  SpeedRoommatingTests
//
//  Created by Thomas Lee on 26/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit
@testable import SpeedRoommating

struct MockImageProvider : IImageProvider {
    func requestImage(atUrl imageUrl: URL, onComplete: @escaping (Result<UIImage?, Error>) -> Void) {
        onComplete(.success(#imageLiteral(resourceName: "frederick-douglass.jpg")))
    }
    
    func deleteCache(onComplete: @escaping () -> Void) {}
}
