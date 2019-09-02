//
//  FlickrImageData.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

struct FlickrImageData: Decodable {
    let description: String
    let authorId: String
    let dateTaken: Date
    let title: String
    let author: String
    let mediaLink: String
    let media: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case description
        case authorId
        case dateTaken
        case title
        case author
        case mediaLink = "link"
        case media
    }
}
