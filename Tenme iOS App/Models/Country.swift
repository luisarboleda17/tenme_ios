//
//  Country.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/9/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class Country: Codable {
    var countryCode: Int? {
        get {
            if let code = Int(dial_code.replacingOccurrences(of: "+", with: "")) {
                return code
            }
            return nil
        }
        set {
            dial_code = "+" + String(newValue ?? 0)
        }
    }
    private var dial_code: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case dial_code
    }
    
    init(code: Int, name: String) {
        self.dial_code = String(code)
        self.name = name
        self.countryCode = code
    }
}
