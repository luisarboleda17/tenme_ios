//
//  OfferServiceViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol RequestServiceViewModelProtocol {
    var viewDelegate: RequestServiceControllerProtocol! { get set }
    var navDelegate: RequestServiceCoordinatorProtocol! { get set }
    
    init(_ navDelegate: RequestServiceCoordinatorProtocol, viewDelegate: RequestServiceControllerProtocol)
    func showCategories()
    func showZones()
    func showDays()
    func selected(category: Category)
    func selected(zone: Zone)
    func selected(weeklyAvailability: WeeklyAvailability)
    func requestService(dailyHours: Int, hourlyRate: Double)
}

class RequestServiceViewModel: RequestServiceViewModelProtocol {
    internal var navDelegate: RequestServiceCoordinatorProtocol!
    internal var viewDelegate: RequestServiceControllerProtocol!
    
    internal var request: RequestServiceRequest = RequestServiceRequest()
    
    required init(_ navDelegate: RequestServiceCoordinatorProtocol, viewDelegate: RequestServiceControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func showCategories() {
        navDelegate.showCategories()
    }
    
    func showZones() {
        navDelegate.showZones()
    }
    
    func showDays() {
        navDelegate.showDays()
    }
    
    func selected(category: Category) {
        request.categoryId = category.id
        viewDelegate.updated(categoryName: category.name)
    }
    
    func selected(zone: Zone) {
        request.zoneId = zone.id
        viewDelegate.updated(zoneName: zone.name)
    }
    
    func selected(weeklyAvailability: WeeklyAvailability) {
        request.weeklyAvailability = weeklyAvailability
        viewDelegate.updated(weeklyAvailabilityNames: self.getWeeklyAvailabilityNames())
    }
    
    func requestService(dailyHours: Int, hourlyRate: Double) {
        request.dailyHours = dailyHours
        request.hourlyRate = hourlyRate
        
        print("Ready to request")
        print(request.toDictionary())
        
        navDelegate.search(servicesWithRequest: request)
    }
    
    private func getWeeklyAvailabilityNames() -> String {
        var names: [String] = []
        
        if let availability = request.weeklyAvailability {
            if (availability.monday) { names.append("Lunes") }
            if (availability.tuesday) { names.append("Martes") }
            if (availability.wednesday) { names.append("Miércoles") }
            if (availability.thursday) { names.append("Jueves") }
            if (availability.friday) { names.append("Viernes") }
            if (availability.saturday) { names.append("Sábado") }
            if (availability.sunday) { names.append("Domingo") }
        }
        
        return names.joined(separator: ", ")
    }
}
