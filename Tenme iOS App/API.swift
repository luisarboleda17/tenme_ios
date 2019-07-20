//
//  API.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct API {
    
    #if DEBUG
        static let base = "http://127.0.0.1:3000/"
    #else
        static let base = "http://facebook.com:3000/"
    #endif
    
    struct Auth {
        static let login = API.base + "auth/login"
        static let checkUser = API.base + "auth/user/"
        static let signUp = API.base + "auth/signup"
    }
    struct Service {
        static let collectionBase = API.base + "services"
        static let categories = API.base + "services/categories"
        static let zones = API.base + "services/zones"
    }
    struct User {
        static let balance = API.base + "users/me/balance"
    }
    
    struct Utils {
        static let banks = API.base + "banks"
    }
}
