//
//  FlickrServiceError.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

struct FlickrServiceError: Decodable {
    
    let error: String?
    let errorDescription: String?
    let message: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case error
        case message
        case code
        case errorDescription = "error_description"
    }
}
