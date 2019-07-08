//
//  Service.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class Service: Codable {
    var zoneId: String!
    var categoryId: String!
    
    var dailyHours: Int!
    var hourlyRate: Double!
    var weeklyAvailability: WeeklyAvailability!
}
