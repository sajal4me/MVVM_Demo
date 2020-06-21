//
//  Data+Extension.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import Foundation

extension Data {
    
    func decoded<T: ModelType>() throws -> T {
        return try T.decoder.decode(T.self, from: self)
    }
}

