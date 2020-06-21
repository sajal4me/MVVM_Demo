//
//  UserDetailFetcher.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import Foundation

protocol DetailsFetcher {
    func fetch(complitionQueue: DispatchQueue, usersResponse: @escaping (Result<Users, Error>) -> Void)
}

extension DetailsFetcher {
    /// return default HTTPNetworking()
    static var networking: Networking {
        return HTTPNetworking()
    }
}

struct UserDetailsFetcher: DetailsFetcher {
    
   private let networking: Networking
    
    // Initialize the fetcher with a networking object
    init(networking: Networking = networking) {
        self.networking = networking
    }
    
    
    /// Fetch data, returing a Response object if successful
    /// - Parameters:
    ///   - complitionQueue: Defines the callback on a specific Queue
    ///   - usersResponse: A @escaping clouser of type Result type
    func fetch(complitionQueue: DispatchQueue = .main, usersResponse: @escaping (Result<Users, Error>) -> Void) {
        networking.request(from: UserEndPoint.fetchUsers) { response in
            
            switch response {
            case .success(let data):
                do {
                    let decoded = try data.decoded() as Users
                    complitionQueue.async {
                        usersResponse(.success(decoded))
                    }
                } catch {
                    complitionQueue.async {
                        usersResponse(.failure(error))
                    }
                }
            case .failure(let error):
                complitionQueue.async {
                    usersResponse(.failure(error))
                }
            }
        }
    }
}


