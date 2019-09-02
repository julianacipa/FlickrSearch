//
//  DateHandler.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

enum DateError: String, Error {
    case invalidDate
}

class DateHandler {
    public static let dateDecoding: (Decoder) -> Date = { (decoder) -> Date in
        do {
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            
            if let date = formatter.date(from: dateStr) {
                return date
            } else {
                throw DateError.invalidDate
            }
        } catch {
            print("error parsing date")
        }
        return Date()
    }
}
