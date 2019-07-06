//
//  User.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

enum DocumentType: String, Codable {
    case id = "id"
    case passport = "passport"
}

enum BankAccountType: String, Codable {
    case saving = "saving"
    case checking = "checking"
}

struct Document: Codable {
    var type: DocumentType!
    var id: String!
    
    func toDictionary() -> [String: Any]? {
        if let type = self.type,
            let id = self.id {
            return [
                "type": type.rawValue,
                "id": id
            ]
        } else {
            return nil
        }
    }
}
struct Phone: Codable {
    var countryCode: Int!
    var phoneNumber: Int!
    
    init(countryCode: Int, phoneNumber: Int) {
        self.countryCode = countryCode
        self.phoneNumber = phoneNumber
    }
    
    func toDictionary() -> [String: Any]? {
        if let code = self.countryCode, let number = self.phoneNumber {
            return [
                "countryCode": code,
                "phoneNumber": number,
            ]
        } else {
            return nil
        }
    }
}
struct BankInfo: Codable {
    var bankId: String!
    var accountType: BankAccountType!
    var number: Int!
    
    func toDictionary() -> [String: Any]? {
        if let id = self.bankId,
            let type = self.accountType,
            let number = self.number {
            return [
                "bankId": id,
                "accountType": type.rawValue,
                "number": number
            ]
        } else {
            return nil
        }
    }
}

struct User: Codable {
    var _id: String!
    var firstName: String!
    var lastName: String!
    var document: Document!
    var phone: Phone!
    var email: String!
    
    var bankInfo: BankInfo!
    var balance: Double!
    var score: Int!
    
    var documentPhotoUrl: String!
    var facebookId: Int!

    var apcAllowed: Bool!
    var status: Int!
    var emailValid: Bool!
}
