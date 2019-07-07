//
//  Category.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class Category: Codable {
    var id: String!
    var name: String!
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
