//
//  HTTPNetworking.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import Foundation

protocol Networking {
  typealias CompletionHandler = (Result<Data, Error>) -> Void
  
  func request(from: Endpoint, completion: @escaping CompletionHandler)
}

enum CustomError: Error {
    case badURL
    case invalidResponse
    case someThingWentWrong(code: Int, message: String)
    
    var localizedError: String {
        switch self {
        case .badURL:
            return self.localizedDescription
        case .invalidResponse:
            return "Invalid Response. Please Try again."
        case .someThingWentWrong:
            return "Some Thing went wrong. Please Try again."
        }
    }
}

enum ResponseStatusCode {
    
    static let successMinRange = 200
    static let successMaxRange = 299
    static let badrequest = 400
    static let noInternet = 503
    
    case success
    case faliure(error: CustomError)
    
    init(code: Int) {
        switch code {
            
        case ResponseStatusCode.successMinRange...ResponseStatusCode.successMaxRange:
            self = .success
            
        case ResponseStatusCode.badrequest:
            let error = CustomError.someThingWentWrong(code: code, message: "Bad Request.")
            self = .faliure(error: error)
            
        case ResponseStatusCode.noInternet:
            let error = CustomError.someThingWentWrong(code: code, message: "No Internet.")
            self = .faliure(error: error)
            
        default:
            let error = CustomError.someThingWentWrong(code: code, message: "Something went wrong.")
            self = .faliure(error: error)
        }
    }
}


struct HTTPNetworking: Networking {
    
    func request(from: Endpoint, completion: @escaping CompletionHandler) {
    
        let component = createURL_ComponentFactory(from: from)
        guard let url =  component.url else {
            completion(.failure(CustomError.badURL))
            return
        }
        
        let request = createRequestFactory(from: url)
        let task = createDataTaskFactory(from: request, completion: completion)
        task.resume()
    }
    
    private func createURL_ComponentFactory(from: Endpoint) -> URLComponents {
        var component = URLComponents()
        component.scheme = from.scheme
        component.host = from.baseURL
        component.path = from.path
        component.queryItems = from.parameters
        
        return component
    }
    
    
    private func createRequestFactory(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        return request
    }
    
    
    private func createDataTaskFactory(from request: URLRequest,
                                       completion: @escaping CompletionHandler) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
              completion(.failure(error))
            }
            if let httpResponse = response as? HTTPURLResponse {
                let status = ResponseStatusCode(code: httpResponse.statusCode)
                
                switch status {
                case .success:
                    if let data = data {
                        completion(.success(data))
                    } else {
                        completion(.failure(CustomError.invalidResponse))
                    }
                case .faliure(let error):
                     completion(.failure(error))
                }
                
            }
        }
    }
}
