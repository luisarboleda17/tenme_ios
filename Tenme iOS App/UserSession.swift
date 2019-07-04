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
    let userDefaults: UserDefaults? = UserDefaults(suiteName: "tenme-user")
    
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
        if let userDefaults = self.userDefaults,
            let userData = userDefaults.data(forKey: "user") {
            
            do {
                let user = try JSONDecoder().decode(User.self, from: userData)
                self.user = user
            } catch {
                print("Error decoding object to json. \(error)")
            }
        }
    }
    
    private func save(_ user: User) {
        do {
            let userData = try JSONEncoder().encode(user)
            if let userDefaults = self.userDefaults {
                userDefaults.set(userData, forKey: "user")
            }
        } catch {
            print("Error encoding object to json. \(error)")
        }
    }
}
