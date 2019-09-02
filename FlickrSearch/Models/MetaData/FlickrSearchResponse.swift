//
//  FlickrSearchResponse.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

struct FlickrSearchResponse: Decodable {
    let generator: String
    let items: [FlickrImageData]
    
    enum CodingKeys: String, CodingKey {
        case generator
        case items
    }
}
