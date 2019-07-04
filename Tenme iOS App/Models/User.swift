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

struct User: Codable {
    struct Document: Codable {
        // var type: DocumentType!
        var id: String!
    }
    struct Phone: Codable {
        var countryCode: Int!
        var phoneNumber: Int!
    }
    struct BankInfo: Codable {
        var bankId: String!
        // var accountType: BankAccountType!
        var number: Int!
    }
    
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
