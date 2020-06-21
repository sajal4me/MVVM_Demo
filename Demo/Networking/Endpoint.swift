//
//  Endpoint.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    // HTTP or HTTPS
    var scheme: String { get }
    
    // Example - http://www.mocky.io
    var baseURL: String { get }
    
    // Example - /v2/5e25329d2f00007f00ce27e5
    var path: String { get }
    
    var parameters: [URLQueryItem]? { get }
    
    // Example - GET
    var method: String { get }
}


enum UserEndPoint: Endpoint {
    case fetchUsers
    
    var scheme: String {
        switch self {
        default:
            return "http"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "www.mocky.io"
        }
    }
    
    var path: String {
        switch self {
        case .fetchUsers:
            return "/v2/5e25329d2f00007f00ce27e5"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .fetchUsers:
            return "Get"
        }
    }
}
