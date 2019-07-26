//
//  Zone.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class Zone: Codable {
    var _id: String!
    var name: String!
    
    var id: String! {
        get { return self._id }
        set { self._id = id }
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
