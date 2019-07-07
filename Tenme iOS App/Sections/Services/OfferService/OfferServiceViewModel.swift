//
//  OfferServiceViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol OfferServiceViewModelProtocol {
    var viewDelegate: OfferServiceControllerProtocol! { get set }
    var navDelegate: PostServiceCoordinatorProtocol! { get set }
    
    init(_ navDelegate: PostServiceCoordinatorProtocol, viewDelegate: OfferServiceControllerProtocol)
    func showCategories()
    func showZones()
    func showDays()
    func selected(category: Category)
    func selected(zone: Zone)
    func selected(weeklyAvailability: WeeklyAvailability)
    func postService(dailyHours: Int, hourlyRate: Double)
}

class OfferServiceViewModel: OfferServiceViewModelProtocol {
    internal var navDelegate: PostServiceCoordinatorProtocol!
    internal var viewDelegate: OfferServiceControllerProtocol!
    
    internal var offerRequest: PostServiceRequest = PostServiceRequest()
    
    required init(_ navDelegate: PostServiceCoordinatorProtocol, viewDelegate: OfferServiceControllerProtocol) {
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
        offerRequest.categoryId = category.id
        viewDelegate.updated(categoryName: category.name)
    }
    
    func selected(zone: Zone) {
        offerRequest.zoneId = zone.id
        viewDelegate.updated(zoneName: zone.name)
    }
    
    func selected(weeklyAvailability: WeeklyAvailability) {
        self.offerRequest.weeklyAvailability = weeklyAvailability
        viewDelegate.updated(weeklyAvailabilityNames: self.getWeeklyAvailabilityNames())
    }
    
    func postService(dailyHours: Int, hourlyRate: Double) {
        offerRequest.dailyHours = dailyHours
        offerRequest.hourlyRate = hourlyRate
        print(offerRequest.toDictionary())
    }
    
    private func getWeeklyAvailabilityNames() -> String {
        var names: [String] = []
        
        if let availability = self.offerRequest.weeklyAvailability {
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
