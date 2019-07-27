//
//  SignInRequest.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/6/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol SignUpRequestProtocol {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var document: Document? { get set }
    var phone: Phone? { get set }
    var email: String? { get set }
    
    var apcAllowed: Bool? { get set }
    
    var password: String? { get set }
    var facebookId: String? { get set }
    
    func toDictionary() -> [String: Any]?
}

class SignUpRequest: Codable, SignUpRequestProtocol {
    var firstName: String?
    var lastName: String?
    var document: Document?
    var phone: Phone?
    var email: String?
    
    var apcAllowed: Bool?
    
    var password: String?
    var facebookId: String?
    
    /**
     Get parameters ready for request
     */
    func toDictionary() -> [String: Any]? {
        if let firstName = self.firstName,
            let lastName = self.lastName,
            let document = self.document?.toDictionary(),
            let phone = self.phone?.toDictionary(),
            let email = self.email,
            let apcAllowed = self.apcAllowed {
            
            var baseDict: [String:Any] = [
                "firstName": firstName,
                "lastName": lastName,
                "document": document as Any,
                "phone": phone as Any,
                "email": email,
                "apcAllowed": apcAllowed,
                "documentPhotoUrl": "http://test.com" // TODO: Check photo upload
            ]
            
            if let pass = self.password {
                baseDict["password"] = pass
            }
            
            if let fbId = self.facebookId {
                baseDict["facebookId"] = fbId
            }
            
            return baseDict
        } else {
            return nil
        }
    }
}
