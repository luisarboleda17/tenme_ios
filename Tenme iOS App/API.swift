//
//  API.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct API {
    static let base = "http://127.0.0.1:3000/"
    struct Auth {
        static let login = API.base + "auth/login"
        static let checkUser = API.base + "auth/user/"
        static let signUp = API.base + "auth/signup"
    }
    struct Service {
        static let collectionBase = API.base + "services/"
        static let categories = API.base + "services/categories"
        static let zones = API.base + "services/zones"
    }
}
