//
//  WeeklyAvailabilityViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol WeeklyAvailabilityViewModelProtocol {
    init(_ navDelegate: (ServiceFormCoordinatorProtocol & PostServiceCoordinatorProtocol)!, viewDelegate: WeeklyAvailabilityControllerProtocol, availability: WeeklyAvailability?)
    
    func getDaysNumber() -> Int
    func getDay(forIndex index: Int) -> (name: String, selected: String?)
    func select(dayAtIndex index: Int)
    func selectedRanges(ranges: [DayAvailabilityRange])
}

class WeeklyAvailabilityViewModel: WeeklyAvailabilityViewModelProtocol {
    internal var navDelegate: (ServiceFormCoordinatorProtocol & PostServiceCoordinatorProtocol)!
    internal var viewDelegate: WeeklyAvailabilityControllerProtocol!
    
    private var weeklyAvailability: WeeklyAvailability!
    private var selectedIndex: Int = 0
    
    required init(_ navDelegate: (ServiceFormCoordinatorProtocol & PostServiceCoordinatorProtocol)!, viewDelegate: WeeklyAvailabilityControllerProtocol, availability: WeeklyAvailability?) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
        self.weeklyAvailability = availability ?? WeeklyAvailability(
            monday: [],
            tuesday: [],
            wednesday: [],
            thursday: [],
            friday: [],
            saturday: [],
            sunday: []
        )
    }
    
    func getDaysNumber() -> Int {
        return 7
    }
    
    func getDay(forIndex index: Int) -> (name: String, selected: String?) {
        switch index {
        case 0:
            return ("Lunes", nil)
        case 1:
            return ("Martes", nil)
        case 2:
            return ("Miércoles", nil)
        case 3:
            return ("Jueves", nil)
        case 4:
            return ("Viernes", nil)
        case 5:
            return ("Sábado", nil)
        case 6:
            return ("Domingo", nil)
        default:
            return ("", nil)
        }
    }
    
    func select(dayAtIndex index: Int) {
        selectedIndex = index
        switch index {
        case 0:
            self.navDelegate.showRanges(ranges: weeklyAvailability.monday)
        case 1:
            self.navDelegate.showRanges(ranges: weeklyAvailability.tuesday)
        case 2:
            self.navDelegate.showRanges(ranges: weeklyAvailability.wednesday)
        case 3:
            self.navDelegate.showRanges(ranges: weeklyAvailability.thursday)
        case 4:
            self.navDelegate.showRanges(ranges: weeklyAvailability.friday)
        case 5:
            self.navDelegate.showRanges(ranges: weeklyAvailability.saturday)
        case 6:
            self.navDelegate.showRanges(ranges: weeklyAvailability.sunday)
        default: break
        }
    }
    
    func selectedRanges(ranges: [DayAvailabilityRange]) {
        switch selectedIndex {
        case 0:
            weeklyAvailability.monday = ranges
        case 1:
            weeklyAvailability.tuesday = ranges
        case 2:
            weeklyAvailability.wednesday = ranges
        case 3:
            weeklyAvailability.thursday = ranges
        case 4:
            weeklyAvailability.friday = ranges
        case 5:
            weeklyAvailability.saturday = ranges
        case 6:
            weeklyAvailability.sunday = ranges
        default: break
        }
        self.navDelegate.selected(weeklyAvailability: self.weeklyAvailability)
    }
}
