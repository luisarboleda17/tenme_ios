//
//  PostServiceRequest.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class PostServiceRequest: Codable {
    var zone: String?
    var category: String?
    
    var dailyHours: Int?
    var hourlyRate: Double?
    var weeklyAvailability: WeeklyAvailability?
    
    func toDictionary() -> [String: Any]? {
        if let zone = self.zone,
            let category = self.category,
            let dailyHours = self.dailyHours,
            let hourlyRate = self.hourlyRate,
            let weekAvailability = self.weeklyAvailability {
            return [
                "zone": zone,
                "category": category,
                "dailyHours": dailyHours,
                "hourlyRate": hourlyRate,
                "weeklyAvailability": weekAvailability.toDictionary()
            ]
        } else {
            return nil
        }
    }
}