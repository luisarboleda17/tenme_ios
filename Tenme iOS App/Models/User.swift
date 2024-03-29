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
    var valid: Bool?
    
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


struct User: Codable {
    var id: String!
    var firstName: String!
    var lastName: String!
    var document: Document!
    var phone: Phone!
    var email: String!
    
    var balance: Double!
    var score: Int!
    
    var documentPhotoUrl: String?
    var facebookId: String?

    var apcAllowed: Bool!
    var status: Int!
    var emailValid: Bool!
}
