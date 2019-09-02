//
//  Date+extensions.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

extension Date {
    func shortReadableString() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        
        let timeStamp = dateFormatter.string(from: self)
        
        return timeStamp
    }
}
