//
//  UserListViewModel.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import Foundation

protocol UserListLoadingStateDelegate: AnyObject {
    func willLoad()
    func didLoad()
    func didFail(error: Error)
}

extension UserListLoadingStateDelegate {
    // optional Method
    func willLoad() { }
    func didFail(error: Error) { }
}

final class UserListViewModel {
    
    private lazy var fetcher = UserDetailsFetcher()
    private var users = Users()
    private weak var delegate: UserListLoadingStateDelegate?
    
    init(_ viewController: UserListViewController) {
        delegate = viewController
    }
    
    func fetchUsers() {
        delegate?.willLoad()
        fetcher.fetch(usersResponse: { [weak self] (results) in
            
            guard let self = self else { return }
            
            switch results {
            case .success(let users):
                self.users = users
                self.delegate?.didLoad()
                
            case .failure(let error):
               self.delegate?.didFail(error: error)
            }
        })
    }
    
    
}

extension UserListViewModel {
    
    var count: Int {
        return users.count
    }
    
    func user(at index: IndexPath) -> UserViewModel {
        return UserViewModel(users[index.row])
    }
}


final class UserViewModel {
    private let user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    var fullName: String {
        return "\(user.firstName) \(user.lastName)"
    }
    
    var email: String {
        return user.email
    }
    
    var gender: String {
        return user.gender.rawValue
    }
    var message: String? {
        return user.message
    }
}

