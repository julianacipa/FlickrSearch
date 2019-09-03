//
//  UIImageViewTests.swift
//  FlickrSearchTests
//
//  Created by Juliana Cipa on 03/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

@testable import FlickrSearch

import XCTest

class UIImageViewTests: XCTestCase {

    static let imageUrl: String = "https://via.placeholder.com/150/24f355"
    
    override func setUp() {}
    override func tearDown() {}

    func testImageIsCachedIfLoadedOnce() {
        let imageView: UIImageView = UIImageView()
        
        imageView.loadImage(urlString: UIImageViewTests.imageUrl)
        
        sleep(5)
        
        let cachedImage = imageCache.object(forKey: UIImageViewTests.imageUrl as AnyObject) as? UIImage
        
        XCTAssertNotNil(cachedImage, "Image should be cashed")
    }
}
