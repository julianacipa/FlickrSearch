//
//  FlickrPhoto.swift
//  FlickrPhoto
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import UIKit

class FlickrPhoto: Equatable {
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
    
    func loadLargeImage(_ completion: @escaping (Result<FlickrPhoto>) -> Void) {
        guard let loadURL = flickrImageURL() else {
            DispatchQueue.main.async {
                completion(Result.error(Error.invalidURL))
            }
            
            return
        }
        
        let loadRequest = URLRequest(url:loadURL)
        
        URLSession.shared.dataTask(with: loadRequest) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(Result.error(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(Result.error(Error.noData))
                }
                return
            }
            
            let returnedImage = UIImage(data: data)
            self.thumbnail = returnedImage
            
            DispatchQueue.main.async {
                completion(Result.results(self))
            }
            }.resume()
    }
    
    func sizeToFillWidth(of size:CGSize) -> CGSize {
        guard let thumbnail = thumbnail else {
            return size
        }
        
        let imageSize = thumbnail.size
        var returnSize = size
        
        let aspectRatio = imageSize.width / imageSize.height
        
        returnSize.height = returnSize.width / aspectRatio
        
        if returnSize.height > size.height {
            returnSize.height = size.height
            returnSize.width = size.height * aspectRatio
        }
        
        return returnSize
    }
    
    static func ==(lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
        return lhs.mediaLink == rhs.mediaLink
    }
}
