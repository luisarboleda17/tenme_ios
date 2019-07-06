//
//  SignInResponse.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/5/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class SignInResponse: Codable {
    var token: String!
    var user: User!
}
