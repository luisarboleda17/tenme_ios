//
//  API.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct API {
    static let base = "http://localhost:3000/"
    struct Auth {
        static let login = API.base + "login"
    }
}
