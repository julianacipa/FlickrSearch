//
//  UIImageView+extensions.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 03/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation
import UIKit

public var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImage(urlString: String) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            imageCache.setObject(image!, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }.resume()
    }
}
