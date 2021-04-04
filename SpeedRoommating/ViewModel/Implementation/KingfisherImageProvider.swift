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

public class KingfisherImageProvider : IImageProvider, ImageDownloaderDelegate {
    
    private let cache = ImageCache.default
    private let downloader = ImageDownloader(name: "VenueImageDownloader")
    public let overrideScaleFactor: CGFloat?
    
    init(overrideScaleFactor: CGFloat? = nil) {
        self.overrideScaleFactor = overrideScaleFactor
        downloader.requestsUsePipelining = true
    }
  
    func requestImage(atUrl imageUrl: URL, onComplete: @escaping (Result<UIImage?, Error>) -> Void) {
                
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
    
    func deleteCache(onComplete: @escaping () -> Void) {
        cache.clearMemoryCache()
        cache.clearDiskCache(completion: onComplete)
    }
    
    private func fetchImageFromCache(url imageUrl: URL, onComplete: @escaping (Result<UIImage?, Error>) -> Void) {
        cache.retrieveImage(forKey: imageUrl.absoluteString) {
            result in
            switch result {
            case .success(let value):
                onComplete(.success(value.image))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
    private func downloadImage(url imageUrl: URL, onComplete: @escaping (Result<UIImage?, Error>) -> Void) {
        downloader.downloadImage(with: imageUrl) { result in
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
