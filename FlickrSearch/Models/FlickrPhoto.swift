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
  let published: String
  let title: String
  let author: String
  let media: String
  let link: String
  
  init (description: String,
        authorId: String,
        published: String,
        title: String,
        author: String,
        media: String,
        link: String) {
    self.description = description
    self.authorId = authorId
    self.published = published
    self.title = title
    self.author = author
    self.media = media
    self.link = link
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
    return lhs.link == rhs.link
  }
}
