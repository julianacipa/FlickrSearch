//
//  FlickrPhoto.swift
//  FlickrPhoto
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import UIKit

class FlickrPhoto {
    var thumbnail: UIImage?
    
    var description: String
    var authorId: String
    var dateTaken: String
    var title: String
    var author: String
    var media: String
    var mediaLink: String
    
    init?(withData photoObject:[String: AnyObject]) {
        guard let descriptionData = photoObject["description"] as? String,
            let authorIdData = photoObject["author_id"] as? String,
            let dateTakenData = photoObject["date_taken"] as? String,
            let titleData = photoObject["title"] as? String,
            let authorData = photoObject["author"] as? String,
            let mediaLinkData = photoObject["link"] as? String,
            let mediaObjects = photoObject["media"] as? [String: AnyObject],
            let mediaData = mediaObjects["m"] as? String
            else {
                return nil
        }
        
        self.description = descriptionData
        self.authorId = authorIdData
        self.dateTaken = dateTakenData
        self.title = titleData
        self.author = authorData
        self.media = mediaData
        self.mediaLink = mediaLinkData
    }
    
    func flickrImageURL() -> URL? {
        if let url =  URL(string: media) {
            return url
        }
        return nil
    }
    
    enum Error: Swift.Error {
        case invalidURL
        case noData
    }
}
