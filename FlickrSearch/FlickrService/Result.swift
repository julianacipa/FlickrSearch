//
//  Result.swift
//  Result
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation

enum Result<ResultType> {
    case results(ResultType)
    case error(Error)
}
