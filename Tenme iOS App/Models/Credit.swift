//
//  Credit.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct Credit: Codable {
    struct PaymentMethod: Codable {
        let key: String
        let name: String
        
        init(key: String, name: String) {
            self.key = key
            self.name = name
        }
    }
}
