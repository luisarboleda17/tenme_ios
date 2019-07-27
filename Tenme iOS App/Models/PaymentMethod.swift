//
//  PaymentMethod.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/27/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

enum PaymentMethodType {
    case card
    case bank
}

protocol PaymentMethod {
    func getType() -> PaymentMethodType
    func getNumeration() -> Int
}

struct CreditCard: PaymentMethod {
    let cardLast4: Int
    let cardholderName: String
    
    func getType() -> PaymentMethodType {
        return PaymentMethodType.card
    }
    
    func getNumeration() -> Int {
        return self.cardLast4
    }
}

struct BankAccount: PaymentMethod {
    enum AccountType: String, Codable {
        case saving = "saving"
        case checking = "checking"
    }
    
    let bankId: String
    let type: AccountType
    let number: Int
    
    func toDict() -> [String:Any] {
        return [
            "bankId": self.bankId,
            "accountType": self.type.rawValue,
            "number": self.number
        ]
    }
    
    func getType() -> PaymentMethodType {
        return PaymentMethodType.bank
    }
    
    func getNumeration() -> Int {
        return self.number
    }
}
