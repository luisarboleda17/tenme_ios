//
//  RequestServiceRequest.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

class RequestServiceRequest: Codable {
    var zone: String?
    var category: String?
    
    var dailyHours: Int?
    var hourlyRate: Double?
    var weeklyAvailability: WeeklyAvailability?
    
    func toDictionary() -> [String: Any]? {
        if let dailyHours = self.dailyHours,
            let hourlyRate = self.hourlyRate {
            return [
                "dailyHours": dailyHours,
                "hourlyRate": hourlyRate,
                "days": getDaysCount()
            ]
        } else {
            return nil
        }
    }
    
    private func getDaysCount() -> Int {
        if let weekAvailability = self.weeklyAvailability {
            var daysCount = 0;
            
            if (weekAvailability.monday) { daysCount += 1 }
            if (weekAvailability.tuesday) { daysCount += 1 }
            if (weekAvailability.wednesday) { daysCount += 1 }
            if (weekAvailability.thursday) { daysCount += 1 }
            if (weekAvailability.friday) { daysCount += 1 }
            if (weekAvailability.saturday) { daysCount += 1 }
            if (weekAvailability.sunday) { daysCount += 1 }
            
            return daysCount
        } else {
            return 0
        }
    }
}
