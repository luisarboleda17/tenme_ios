//
//  OfferServiceViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

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
    func postService(hourlyRate: Double)
    func getWeeklyAvailabilityNames() -> String?
}

class OfferServiceViewModel: OfferServiceViewModelProtocol {
    internal var navDelegate: PostServiceCoordinatorProtocol!
    internal var viewDelegate: OfferServiceControllerProtocol!
    
    internal var offerRequest: PostServiceRequest = PostServiceRequest()
    private var categorySelected = false
    private var zoneSelected = false
    private var weeklyAvailabilitySelected = false
    
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
        navDelegate.showDays(availability: offerRequest.weeklyAvailability)
    }
    
    func selected(category: Category) {
        offerRequest.category = category.id
        viewDelegate.updated(categoryName: category.name)
        categorySelected = true
    }
    
    func selected(zone: Zone) {
        offerRequest.zone = zone.id
        viewDelegate.updated(zoneName: zone.name)
        zoneSelected = true
    }
    
    func selected(weeklyAvailability: WeeklyAvailability) {
        self.offerRequest.weeklyAvailability = weeklyAvailability
        weeklyAvailabilitySelected = true
    }
    
    func postService(hourlyRate: Double) {
        offerRequest.hourlyRate = hourlyRate
        
        guard categorySelected else {
            self.viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar una categoría")
            return
        }
        
        guard zoneSelected else {
            self.viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar una zona")
            return
        }
        
        guard weeklyAvailabilitySelected else {
            self.viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar al menos un día de disponibilidad")
            return
        }
        
        if let parameters = offerRequest.toDictionary() {
            print(parameters)
            
            self.viewDelegate.showLoading(
                loading: true,
                completion: {
                    Alamofire.request(
                        API.Service.collectionBase,
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.default,
                        headers: [
                            "Authorization": "Bearer " + (UserSession.current.token ?? "")
                        ]
                        ).validate().responseData(
                            queue: DispatchQueue.backgroundQueue,
                            completionHandler: { response in
                                self.viewDelegate.showLoading(
                                    loading: false,
                                    completion: {
                                        switch response.result {
                                        case .success:
                                            self.viewDelegate.showAlert(
                                                title: "Servicio ofertado",
                                                message: "Puede ver información del servicio ofertado visualizando el Historial",
                                                completion: { _ in
                                                    self.navDelegate.servicePosted()
                                                }
                                            )
                                        case .failure(let error):
                                            self.viewDelegate.showAlert(title: "Error guardando servicio", message: "\(error)")
                                        }
                                    }
                                )
                        }
                    )
                }
            )
        }
    }
    
    internal func getWeeklyAvailabilityNames() -> String? {
        guard weeklyAvailabilitySelected else {
            return nil
        }
        
        var totalDays = 0
        if let availability = self.offerRequest.weeklyAvailability {
            if (availability.monday.count > 0) { totalDays += 1 }
            if (availability.tuesday.count > 0) { totalDays += 1 }
            if (availability.wednesday.count > 0) { totalDays += 1 }
            if (availability.thursday.count > 0) { totalDays += 1 }
            if (availability.friday.count > 0) { totalDays += 1 }
            if (availability.saturday.count > 0) { totalDays += 1 }
            if (availability.sunday.count > 0) { totalDays += 1 }
        }
        return totalDays > 0 ? "\(totalDays) días" : nil
    }
}
