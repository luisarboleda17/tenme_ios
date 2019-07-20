//
//  Bank.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/15/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct Bank: Codable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
