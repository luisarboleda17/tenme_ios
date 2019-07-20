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
        let paymentMethod: String
        let interestRate: Decimal
        let firstPaymentDate: String
        let approved: Bool
    }
    struct Service: Codable {
        struct Zone: Codable {
            let name: String
        }
        let id: String
        let hourlyRate: Decimal
        let dailyHours: Int
        let zone: Zone
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
}
