//
//  String+extensions.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

extension String {
    func substringBetweenParenthesis() -> String {
        let quote: Character = "\""
        
        let subString: Substring = self
            .drop(while: { $0 != quote }).dropFirst()
            .prefix(while: { $0 != quote }).dropLast()
        
        return String(subString)
    }
}
