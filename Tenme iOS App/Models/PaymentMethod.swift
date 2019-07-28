//
//  PaymentMethod.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/27/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

enum PaymentMethodType: String {
    case card = "card"
    case bank = "account"
}

protocol PaymentMethod {
    func getType() -> PaymentMethodType
    func getNumeration() -> Int
    func getInformation() -> String
    func getId() -> String
}

struct CreditCard: PaymentMethod {
    let id: String
    let cardLast4: Int
    let cardholderName: String
    
    func getId() -> String {
        return id
    }
    
    func getType() -> PaymentMethodType {
        return PaymentMethodType.card
    }
    
    func getInformation() -> String {
        return "VISA / Mastercard"
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
    
    let id: String
    let bankId: String
    let type: AccountType
    let number: Int
    let bankName: String?
    
    func toDict() -> [String:Any] {
        return [
            "bankId": self.bankId,
            "accountType": self.type.rawValue,
            "accountNumber": self.number
        ]
    }
    
    func getId() -> String {
        return id
    }
    
    func getInformation() -> String {
        return bankName ?? ""
    }
    
    func getType() -> PaymentMethodType {
        return PaymentMethodType.bank
    }
    
    func getNumeration() -> Int {
        return self.number
    }
}
