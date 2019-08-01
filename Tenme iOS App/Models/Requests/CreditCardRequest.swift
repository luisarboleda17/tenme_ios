//
//  CreditCardRequest.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct CreditCardRequest: Codable {
    var name: String
    var number: Int
    var expirationMonth: Int
    var expirationYear: Int
    var cvv: Int
    
    func toDict() -> [String:Any] {
        return [
            "cardholderName": name,
            "cardNumber": number,
            "cardExpirationMonth": expirationMonth,
            "cardExpirationYear": expirationYear,
            "cvv": cvv
        ]
    }
}
