//
//  WeeklyAvailability.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

struct DayAvailabilityRange: Codable {
    let startHour: Int
    let endHour: Int
    
    func to_Dict() -> [String:Int] {
        return [
            "startHour": self.startHour,
            "endHour": self.endHour
        ]
    }
}

struct WeeklyAvailability: Codable {
    var monday: [DayAvailabilityRange]
    var tuesday: [DayAvailabilityRange]
    var wednesday: [DayAvailabilityRange]
    var thursday: [DayAvailabilityRange]
    var friday: [DayAvailabilityRange]
    var saturday: [DayAvailabilityRange]
    var sunday: [DayAvailabilityRange]
    
    init(monday: [DayAvailabilityRange],
         tuesday: [DayAvailabilityRange],
         wednesday: [DayAvailabilityRange],
         thursday: [DayAvailabilityRange],
         friday: [DayAvailabilityRange],
         saturday: [DayAvailabilityRange],
         sunday: [DayAvailabilityRange]
    ) {
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }
    
    func toDictionary() -> [String:[[String:Int]]] {
        return [
            "monday": self.monday.compactMap { $0.to_Dict() },
            "tuesday": self.tuesday.compactMap { $0.to_Dict() },
            "wednesday": self.wednesday.compactMap { $0.to_Dict() },
            "thursday": self.thursday.compactMap { $0.to_Dict() },
            "friday": self.friday.compactMap { $0.to_Dict() },
            "saturday": self.saturday.compactMap { $0.to_Dict() },
            "sunday": self.sunday.compactMap { $0.to_Dict() }
        ]
    }
}
