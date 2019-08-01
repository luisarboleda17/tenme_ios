//
//  RequestServiceRequest.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class RequestServiceRequest: Codable {
    var zone: String?
    var category: String?
    
    func toDictionary() -> [String: Any]? {
        return [
            "totalHours": Int.random(in: 1 ..< 5)
        ]
    }
}
