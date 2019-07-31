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
    
    var hourlyRate: Double?
    var weeklyAvailability: WeeklyAvailability?
    
    func toDictionary() -> [String: Any]? {
        if let zone = self.zone,
            let category = self.category,
            let hourlyRate = self.hourlyRate,
            let weekAvailability = self.weeklyAvailability {
            return [
                "zone": zone,
                "category": category,
                "hourlyRate": hourlyRate,
                "weeklyAvailability": weekAvailability.toDictionary()
            ]
        } else {
            return nil
        }
    }
}
