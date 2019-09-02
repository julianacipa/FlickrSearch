//
//  FlickrParseTests.swift
//  FlickrSearchTests
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//
@testable import FlickrSearch

import XCTest

enum FlickrParserError: Error {
    case parse(String)
}

class FlickrParseTests: XCTestCase {
    
    var bundle: Bundle!
    var parser = FlickrParser()
    
    override func setUp() {
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }
    
    func flickrPhoto() throws -> FlickrPhoto {
        let data = try self.data(for: "FlickrSearchResponse")
        let flickrPhotos = try parser.parseFlickrImageData(from: data)
        
        guard let flickrPhoto = flickrPhotos.last else {
            throw FlickrParserError.parse("Can't parse images")
        }
        
        return flickrPhoto
    }
    
    func data(for resource: String) throws -> Data {
        guard let path = bundle.url(forResource: resource, withExtension: "json") else {
            throw FlickrParserError.parse("Can't find '\(resource) file")
        }
        let data = try Data(contentsOf: path)
        
        return data
    }
    
    func testParseFlickrPhotosSuccess() {
        do {
            let data = try self.data(for: "FlickrSearchResponse")
            let flickrPhotos = try parser.parseFlickrImageData(from: data)
            
            XCTAssertEqual(flickrPhotos.count, 20, "Wrong number of images")
            XCTAssertEqual(flickrPhotos.first?.author, "nobody@flickr.com (\"Jim Cumming\")", "wrong author details")
            XCTAssertEqual(flickrPhotos.first?.media, "https://live.staticflickr.com/65535/48664917251_8cdc5e35f2_m.jpg", "wrong media url")
            XCTAssertEqual(flickrPhotos.first?.dateTaken.description, "2019-09-02 16:46:18 +0000", "wrong date")
        } catch {
            XCTAssertNil(error, "Error while parsing images from json")
        }
    }
}
