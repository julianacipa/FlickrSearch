//
//  FlickrService.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//
	
import UIKit

class FlickrService {
  enum Error: Swift.Error {
    case unknownAPIResponse
    case generic
  }
  
  func searchFlickr(for searchTerm: String, completion: @escaping (Result<FlickrSearchResults>) -> Void) {
    guard let searchURL = flickrSearchURL(for: searchTerm) else {
      completion(Result.error(Error.unknownAPIResponse))
      return
    }
    
    let searchRequest = URLRequest(url: searchURL)
    
    URLSession.shared.dataTask(with: searchRequest) { (data, response, error) in
      if let error = error {
        DispatchQueue.main.async {
          completion(Result.error(error))
        }
        return
      }
      
      guard let _ = response as? HTTPURLResponse,
        let data = data
        else {
          DispatchQueue.main.async {
            completion(Result.error(Error.unknownAPIResponse))
          }
          return
      }
      
      do {
        guard let resultsDictionary = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject]
          else {
            DispatchQueue.main.async {
              completion(Result.error(Error.unknownAPIResponse))
            }
            return
        }
        
        guard let photosReceived = resultsDictionary["items"] as? [[String: AnyObject]]
          else {
            DispatchQueue.main.async {
              completion(Result.error(Error.unknownAPIResponse))
            }
            return
        }
        
        let flickrPhotos: [FlickrPhoto] = photosReceived.compactMap { photoObject in
          guard let description = photoObject["description"] as? String,
            let authorId = photoObject["author_id"] as? String,
            let published = photoObject["date_taken"] as? String,
            let title = photoObject["title"] as? String,
            let author = photoObject["author"] as? String,
            let link = photoObject["link"] as? String,
            let mediaObjects = photoObject["media"] as? [String: AnyObject]
            else {
              return nil
            }
          
            guard let media = mediaObjects["m"] as? String
              else {
                return nil
            }
          
            let flickrPhoto = FlickrPhoto(description: description,
                                          authorId: authorId,
                                          published: published,
                                          title: title,
                                          author: author,
                                          media: media,
                                          link: link)

          guard let url = flickrPhoto.flickrImageURL(),
            let imageData = try? Data(contentsOf: url as URL)
            else {
              return nil
          }
          
          if let image = UIImage(data: imageData) {
            flickrPhoto.thumbnail = image
            
            return flickrPhoto
          } else {
            return nil
          }
        }
        
        let searchResults = FlickrSearchResults(searchTerm: searchTerm, searchResults: flickrPhotos)
        
        DispatchQueue.main.async {
          completion(Result.results(searchResults))
        }
      } catch {
        completion(Result.error(error))
        return
      }
    }.resume()
  }
  
  private func flickrSearchURL(for searchTerm:String) -> URL? {
    guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
      return nil
    }
    
    let URLString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(escapedTerm)"
    
    return URL(string:URLString)
  }
}
