//
//  FlickrService.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import UIKit
import Foundation

enum ServiceError: Error {
    case unknownAPIResponse
    case generic
    case error(localizedDescription: String)
}

class FlickrService {
    var parser: FlickrParser = FlickrParser()
    
    func searchFlickr(for searchTerm: String,
                      completion: @escaping (Result<FlickrSearchResults>) -> Void) {
        guard let searchURL = flickrSearchURL(for: searchTerm) else {
            completion(Result.error(ServiceError.unknownAPIResponse))
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
                        completion(Result.error(ServiceError.unknownAPIResponse))
                    }
                    return
            }
            
            do {
                let flickrPhotos: [FlickrPhoto] = try self.parser.parseFlickrImageData(from: data)
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
