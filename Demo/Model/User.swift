//
//  User.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import Foundation

enum Gender: String, Codable {
    
    case male = "Male"
    case female = "Female"
    case transgender = "Transgender"
}

protocol UserDetail {
    associatedtype id
    var firstName : String { get set}
    var lastName  : String { get set}
    var email     : String { get set}
    var gender    : Gender { get set}
    
}

struct User: UserDetail, ModelType {
    typealias id = Int
    
    var firstName: String
    var lastName: String
    var email: String
    var gender: Gender
    let ipAddress: String
    let message: String?
    
}


typealias Users = [User]
