//
//  UserRepository.swift
//  anonymousChat
//
//  Created by Tanmay Chandra Nath on 06/12/23.
//

import Foundation

class UserRepository {
    static let shared = UserRepository()
    private init() {}
    
    var userName: String?
}
