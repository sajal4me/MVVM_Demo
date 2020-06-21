//
//  ArrayExtension.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import Foundation

 /// Confirrm Array with Model Type  to use default  JSONDecoder
extension Array: ModelType where Element: ModelType {
}

