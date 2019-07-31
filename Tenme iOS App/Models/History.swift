//
//  History.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/19/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct History: Codable {
    struct Credit: Codable {
        let id: String
        let amount: Decimal
        let interestRate: Decimal
        let firstPaymentDate: String
        let approved: Bool
    }
    struct Service: Codable {
        struct Zone: Codable {
            let name: String
        }
        struct Category: Codable {
            let name: String
        }
        struct User: Codable {
            let id: String
            let fullName: String
        }
        let id: String
        let hourlyRate: Decimal
        let zone: Zone
        let category: Category
        let user: User
    }
    enum HistoryType: String, Codable {
        case requestedCredit = "requested_credit"
        case offeredService = "offered_service"
        case requestedService = "requested_service"
    }
    
    var id: String
    var type: HistoryType
    var credit: Credit?
    var service: Service?
    var user: String
}
