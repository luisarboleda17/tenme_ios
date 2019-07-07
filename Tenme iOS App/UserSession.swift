//
//  UserSession.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/3/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class UserSession {
    var token: String?
    var user: User?
    
    static let current = UserSession()
    let userDefaults: UserDefaults = UserDefaults(suiteName: "tenme-user") ?? UserDefaults.standard
    
    init() {
        loadUserDetails()
    }
    
    /**
     Open session for user
     */
    func open(forUser user: User, token: String) {
        self.user = user
        self.token = token
        
        self.save(user)
    }
    
    private func loadUserDetails() {
        if let userData = userDefaults.data(forKey: "user"),
            let user = userData.toObject(objectType: User.self) {
            self.user = user
        }
    }
    
    private func save(_ user: User) {
        if let userData = user.toData() {
            userDefaults.set(userData, forKey: "user")
            userDefaults.synchronize()
        }
    }
}
