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
    func requestService()
}

class RequestServiceViewModel: RequestServiceViewModelProtocol {
    internal var navDelegate: RequestServiceCoordinatorProtocol!
    internal var viewDelegate: RequestServiceControllerProtocol!
    
    internal var request: RequestServiceRequest = RequestServiceRequest()
    private var categorySelected = false
    private var zoneSelected = false
    
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
    
    func showDays() { }
    
    func selected(category: Category) {
        request.category = category.id
        viewDelegate.updated(categoryName: category.name)
        categorySelected = true
    }
    
    func selected(zone: Zone) {
        request.zone = zone.id
        viewDelegate.updated(zoneName: zone.name)
        zoneSelected = true
    }
    
    func selected(weeklyAvailability: WeeklyAvailability) { }
    
    func requestService() {
        guard categorySelected else {
            self.viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar una categoría")
            return
        }
        
        guard zoneSelected else {
            self.viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar una zona")
            return
        }
        
        navDelegate.search(servicesWithRequest: request)
    }
}
