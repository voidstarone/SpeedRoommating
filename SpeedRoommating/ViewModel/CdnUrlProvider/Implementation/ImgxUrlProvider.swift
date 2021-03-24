//
//  ImgxUrlProvider.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 23/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit
import ImgixSwift

public struct ImgxUrlProvider : ICdnUrlProvider {
    
    public let imgixClient = ImgixClient.init(host: SpeedRoommatingConfig.imageCdnHost)

    public func pathForImage(named imageName: String, atSize size: CGSize) -> URL {
        return imgixClient.buildUrl(imageName, params: [
            "w": size.width,
            "h": size.height,
            "fit": "crop"
        ])
    }
     
    static let `default`: ICdnUrlProvider = ImgxUrlProvider()
}
