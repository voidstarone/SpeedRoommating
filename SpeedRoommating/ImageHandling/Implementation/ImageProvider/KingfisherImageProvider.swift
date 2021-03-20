//
//  ImageCache.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 20/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import ImgixSwift

enum KingfisherImageProviderError : Error {
    case invalidImage
}

public struct KingfisherImageProvider : IImageProvider {
    
    // Abstract this
    public let imgixClient = ImgixClient.init(host: "images.unsplash.com")
    private let cache = ImageCache.default
    private let downloader = ImageDownloader.default
    public let overrideScaleFactor: CGFloat?
    
    init(overrideScaleFactor: CGFloat? = nil) {
        self.overrideScaleFactor = overrideScaleFactor
    }
  
    public func requestImage(named imageName: String, atSize size: CGSize, onComplete: @escaping (Result<UIImage?, Error>) -> Void) {
        
        let imageUrl = imgixClient.buildUrl(imageName, params: [
            "w": size.width,
            "h": size.height,
            "fit": "crop"
        ])
        
        downloadImage(url: imageUrl) {
            result in
            switch result {
            case .success(let image):
                self.saveToCache(url: imageUrl, image: image!)
                onComplete(.success(image))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    public func deleteCache(onComplete: @escaping () -> Void) {
        cache.clearMemoryCache()
        cache.clearDiskCache(completion: onComplete)
    }
    
    private func fetchImageFromCache(url: URL, onComplete: @escaping (Result<UIImage?, Error>) -> Void) {
        cache.retrieveImage(forKey: url.absoluteString) {
            result in
            switch result {
            case .success(let value):
                onComplete(.success(value.image))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    private func downloadImage(url: URL, onComplete: @escaping (Result<UIImage?, Error>) -> Void) {
        downloader.downloadImage(with: url) { result in
            switch result {
            case .success(let value):
                onComplete(.success(value.image))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    private func saveToCache(url: URL, image: UIImage) {
        cache.store(image, forKey: url.absoluteString)
    }
}
