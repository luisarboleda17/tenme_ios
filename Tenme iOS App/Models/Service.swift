//
//  Service.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class Service: Codable {
    class User: Codable {
        let id: String
        let firstName: String
        let lastName: String
        let fullName: String
        let documentPhotoUrl: String
        let score: Double
    }
    let id: String
    let zone: Zone
    let category: Category
    
    let hourlyRate: Double
    let weeklyAvailability: WeeklyAvailability
    
    var user: User
}
