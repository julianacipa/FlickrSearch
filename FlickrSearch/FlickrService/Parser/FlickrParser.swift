//
//  FlickrParser.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

class FlickrParser: NSObject {
    
    static var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .custom(DateHandler.dateDecoding)
        return jsonDecoder
    }
}

extension FlickrParser {
    func parseFlickrImageData(from data: Data) throws -> [FlickrPhoto] {
        let dict = try FlickrParser.decoder.decode(FlickrSearchResponse.self, from: data)
        let photoItems = dict.items.compactMap { FlickrPhoto(imageData: $0) }
        
        if photoItems.count == 0 { throw ServiceError.unknownAPIResponse }
        
        return photoItems
    }
    
    func parseError(from data: Data) throws -> ServiceError {
        let error = try JSONDecoder().decode(FlickrServiceError.self, from: data)
        
        return .error(localizedDescription: error.errorDescription ?? "")
    }
}
