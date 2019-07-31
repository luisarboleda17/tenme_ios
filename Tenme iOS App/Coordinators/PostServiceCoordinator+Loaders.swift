//
//  PostServiceCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension PostServiceCoordinator {
    internal func loadCategoryView() {
        OperationQueue.main.addOperation {
            if let categoryController = ViewLoader.load(CategoryController.self, xibName: XIBS.Controllers.category) {
                categoryController.bind(CategoryViewModel(self, viewDelegate: categoryController))
                self.navigationController.show(categoryController, sender: self)
            }
        }
    }
    
    internal func loadZoneView() {
        OperationQueue.main.addOperation {
            if let zoneController = ViewLoader.load(ZoneController.self, xibName: XIBS.Controllers.zone) {
                zoneController.bind(ZoneViewModel(self, viewDelegate: zoneController))
                self.navigationController.show(zoneController, sender: self)
            }
        }
    }
    
    internal func loadDayView(availability: WeeklyAvailability?) {
        OperationQueue.main.addOperation {
            if let dayController = ViewLoader.load(WeeklyAvailabilityController.self, xibName: XIBS.Controllers.weeklyAvailability) {
                let viewModel = WeeklyAvailabilityViewModel(self, viewDelegate: dayController, availability: availability)
                self.weekAvailabilityViewModel = viewModel
                dayController.bind(viewModel)
                self.navigationController.show(dayController, sender: self)
            }
        }
    }
    
    internal func loadOfferService() {
        OperationQueue.main.addOperation {
            if let offerServiceController = ViewLoader.load(OfferServiceController.self, xibName: XIBS.Controllers.offerService) {
                let viewModel = OfferServiceViewModel(self, viewDelegate: offerServiceController)
                
                self.offerServiceViewModel = viewModel
                offerServiceController.bind(viewModel)
                
                self.navigationController.show(offerServiceController, sender: self)
            }
        }
    }
    
    internal func loadDayAvailability(ranges: [DayAvailabilityRange]) {
        OperationQueue.main.addOperation {
            if let dayAvailabilityController = ViewLoader.load(DayAvailabilityController.self, xibName: XIBS.Controllers.dayAvailability) {
                dayAvailabilityController.bind(DayAvailabilityViewModel(navDelegate: self, viewDelegate: dayAvailabilityController, ranges: ranges))
                self.navigationController.show(dayAvailabilityController, sender: self)
            }
        }
    }
}
