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
        static let base = "http://localhost:3000/"
    #else
        static let base = "http://tenme.us-east-2.elasticbeanstalk.com/"
    #endif
    
    struct Auth {
        static let login = API.base + "auth/login"
        static let checkUser = API.base + "auth/check"
        static let signUp = API.base + "auth/signup"
    }
    struct Service {
        static let collectionBase = API.base + "services"
        static let categories = API.base + "services/categories"
        static let zones = API.base + "services/zones"
    }
    struct User {
        static let balance = API.base + "users/me/balance"
        static let histories = API.base + "users/me/history"
        static let me = API.base + "users/me"
    }
    struct Credit {
        static let request = API.base + "credit"
    }
    struct Utils {
        static let banks = API.base + "banks"
    }
    struct PaymentMethods {
        static let collectionBase = API.base + "payment-methods"
        static let creditCards = API.base + "payment-methods/credit-cards"
        static let bankAccounts = API.base + "payment-methods/bank-accounts"
    }
}
