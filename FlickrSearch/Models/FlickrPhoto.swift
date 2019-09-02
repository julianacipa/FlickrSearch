//
//  FlickrPhoto.swift
//  FlickrPhoto
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation
import UIKit

class FlickrPhoto {
    @objc dynamic var thumbnail: UIImage?
    
    @objc dynamic var description: String
    @objc dynamic var authorId: String
    @objc dynamic var dateTaken: Date
    @objc dynamic var title: String
    @objc dynamic var author: String
    @objc dynamic var mediaLink: String
    @objc dynamic var media: String
    
    init(description:String,
         authorId: String,
         author: String,
         dateTaken: Date,
         title: String,
         mediaLink: String,
         mediaArray: [String: String]) {
        
        self.description = description
        self.authorId = authorId
        self.dateTaken = dateTaken
        self.title = title
        self.author = author
        self.mediaLink = mediaLink
        self.media = mediaArray.values.first ?? ""
        
        loadImage()
    }
    
    convenience init(imageData: FlickrImageData) {
        self.init(description: imageData.description,
                  authorId: imageData.authorId,
                  author: imageData.author,
                  dateTaken: imageData.dateTaken,
                  title: imageData.title,
                  mediaLink: imageData.mediaLink,
                  mediaArray: imageData.media)
    }
    
    func flickrImageURL() -> URL? {
        if let url =  URL(string: media) {
            return url
        }
        return nil
    }
    
    func loadImage() {
        if let url = flickrImageURL(),
            let imageData = try? Data(contentsOf: url as URL),
            let image = UIImage(data: imageData) {
            thumbnail = image
        }
    }
}
