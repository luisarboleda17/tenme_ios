//
//  WeeklyAvailabilityViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol WeeklyAvailabilityViewModelProtocol {
    var viewDelegate: WeeklyAvailabilityControllerProtocol! { get set }
    var navDelegate: ServiceFormCoordinatorProtocol! { get set }
    
    init(_ navDelegate: ServiceFormCoordinatorProtocol, viewDelegate: WeeklyAvailabilityControllerProtocol)
    
    func getDaysNumber() -> Int
    func getDay(forIndex index: Int) -> (name: String, selected: Bool)
    func select(dayAtIndex index: Int)
}

class WeeklyAvailabilityViewModel: WeeklyAvailabilityViewModelProtocol {
    internal var navDelegate: ServiceFormCoordinatorProtocol!
    internal var viewDelegate: WeeklyAvailabilityControllerProtocol!
    
    private var weeklyAvailability: WeeklyAvailability = WeeklyAvailability(
        monday: false,
        tuesday: false,
        wednesday: false,
        thursday: false,
        friday: false,
        saturday: false,
        sunday: false
    )
    
    required init(_ navDelegate: ServiceFormCoordinatorProtocol, viewDelegate: WeeklyAvailabilityControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func getDaysNumber() -> Int {
        return 7
    }
    
    func getDay(forIndex index: Int) -> (name: String, selected: Bool) {
        switch index {
        case 0:
            return ("Lunes", weeklyAvailability.monday)
        case 1:
            return ("Martes", weeklyAvailability.tuesday)
        case 2:
            return ("Miércoles", weeklyAvailability.wednesday)
        case 3:
            return ("Jueves", weeklyAvailability.thursday)
        case 4:
            return ("Viernes", weeklyAvailability.friday)
        case 5:
            return ("Sábado", weeklyAvailability.saturday)
        case 6:
            return ("Domingo", weeklyAvailability.sunday)
        default:
            return ("", false)
        }
    }
    
    func select(dayAtIndex index: Int) {
        switch index {
        case 0:
            weeklyAvailability.monday = !(weeklyAvailability.monday)
        case 1:
            weeklyAvailability.tuesday = !(weeklyAvailability.tuesday)
        case 2:
            weeklyAvailability.wednesday = !(weeklyAvailability.wednesday)
        case 3:
            weeklyAvailability.thursday = !(weeklyAvailability.thursday)
        case 4:
            weeklyAvailability.friday = !(weeklyAvailability.friday)
        case 5:
            weeklyAvailability.saturday = !(weeklyAvailability.saturday)
        case 6:
            weeklyAvailability.sunday = !(weeklyAvailability.sunday)
        default: break
        }
        viewDelegate.refresh(dayAtIndex: index)
        navDelegate.selected(weeklyAvailability: weeklyAvailability)
    }
}
