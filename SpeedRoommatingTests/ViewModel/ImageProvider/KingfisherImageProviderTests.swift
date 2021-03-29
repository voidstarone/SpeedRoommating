//
//  ImageProviderTests.swift
//  SpeedRoommatingTests
//
//  Created by Thomas Lee on 20/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import XCTest
@testable import SpeedRoommating

class ImageProviderTests: XCTestCase {
    
    var imageProvider: IImageProvider = KingfisherImageProvider()
    let testImageUrl: URL = URL(string: "https://images.unsplash.com/photo-1525268323446-0505b6fe7778")!
    
    override func setUp() {
        imageProvider = KingfisherImageProvider()
    }

    override func tearDown() {

        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestImageNotCached() {
        let willReturnImage = expectation(description: "will return image")
        imageProvider.deleteCache {
            self.imageProvider.requestImage(atUrl: self.testImageUrl) {
                result in
                
                switch result {
                case .success:
                    willReturnImage.fulfill()
                default:
                    break
                }
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testRequestImageCached() {
        let willReturnImage = expectation(description: "will return image")
        imageProvider.deleteCache {
            self.imageProvider.requestImage(atUrl: self.testImageUrl) {
                result in
                self.imageProvider.requestImage(atUrl: self.testImageUrl) {
                    result in
                    
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            willReturnImage.fulfill()
                        }
                    default:
                        break
                    }
                }
            }
        }
        waitForExpectations(timeout: 4, handler: nil)
    }
    
}
