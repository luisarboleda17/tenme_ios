//
//  PostServiceCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension RequestServiceCoordinator {
    internal func loadCategoryView() {
        OperationQueue.main.addOperation {
            if let categoryController = ViewLoader.load(CategoryController.self, xibName: XIBS.Controllers.category) {
                categoryController.bind(CategoryViewModel(self))
                self.navigationController.show(categoryController, sender: self)
            }
        }
    }
    
    internal func loadZoneView() {
        OperationQueue.main.addOperation {
            if let zoneController = ViewLoader.load(ZoneController.self, xibName: XIBS.Controllers.zone) {
                zoneController.bind(ZoneViewModel(self))
                self.navigationController.show(zoneController, sender: self)
            }
        }
    }
    
    internal func loadDayView() {
        OperationQueue.main.addOperation {
            if let dayController = ViewLoader.load(WeeklyAvailabilityController.self, xibName: XIBS.Controllers.weeklyAvailability) {
                dayController.bind(WeeklyAvailabilityViewModel(self, viewDelegate: dayController))
                self.navigationController.show(dayController, sender: self)
            }
        }
    }
    
    internal func loadRequestService() {
        OperationQueue.main.addOperation {
            if let requestServiceController = ViewLoader.load(RequestServiceController.self, xibName: XIBS.Controllers.requestService) {
                let viewModel = RequestServiceViewModel(self, viewDelegate: requestServiceController)
                
                self.requestServiceViewModel = viewModel
                requestServiceController.bind(viewModel)
                
                self.navigationController.show(requestServiceController, sender: self)
            }
        }
    }
    
    internal func loadServices(request: RequestServiceRequest) {
        OperationQueue.main.addOperation {
            if let servicesController = ViewLoader.load(ServicesController.self, xibName: XIBS.Controllers.services) {
                let viewModel = ServicesViewModel(self, request: request)
                
                servicesController.bind(viewModel)
                self.navigationController.show(servicesController, sender: self)
            }
        }
    }
}
