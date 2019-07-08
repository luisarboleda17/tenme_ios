//
//  UserSession.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

fileprivate let TOKEN_KEY = "token"
fileprivate let USER_KEY = "user"
fileprivate let USER_DEFAULT_NAME = "tenme-user"

protocol UserSessionProtocol {
    var isOpen: Bool { get }
}

class UserSession {
    var token: String?
    var user: User?
    var isOpen: Bool = false
    
    static let current = UserSession()
    let userDefaults: UserDefaults = UserDefaults(suiteName: USER_DEFAULT_NAME) ?? UserDefaults.standard
    
    init() {
        loadUserDetails()
    }
    
    /**
     Open session for user
     */
    func open(forUser user: User, token: String) {
        self.user = user
        self.token = token
        self.isOpen = true
        
        self.save(user)
    }
    
    private func loadUserDetails() {
        if let userData = userDefaults.data(forKey: USER_KEY),
            let user = userData.toObject(objectType: User.self),
            let token = userDefaults.string(forKey: TOKEN_KEY) { // TODO: Shoukd load from keychain
            self.user = user
            self.token = token
            self.isOpen = true
        }
    }
    
    private func save(_ user: User) {
        if let userData = user.toData() {
            userDefaults.set(userData, forKey: USER_KEY)
            userDefaults.set(token, forKey: TOKEN_KEY) // TODO: Should use keychain
            userDefaults.synchronize()
        }
    }
}
