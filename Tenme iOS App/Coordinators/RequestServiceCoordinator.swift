//
//  PostServiceCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol RequestServiceCoordinatorProtocol: Coordinator, ServiceFormCoordinatorProtocol {
    init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol)
    
    func start()
    func search(servicesWithRequest request: RequestServiceRequest)
    func serviceRequested()
}

class RequestServiceCoordinator: RequestServiceCoordinatorProtocol {
    internal let TAG = "REQUEST SERVICE COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    internal var requestServiceViewModel: RequestServiceViewModel?
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    func start() {
        loadRequestService()
    }
    
    func showCategories() {
        loadCategoryView()
    }
    
    func showZones() {
        loadZoneView()
    }
    
    func selected(category: Category) {
        if let requestViewModel = self.requestServiceViewModel {
            requestViewModel.selected(category: category)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func selected(zone: Zone) {
        if let requestViewModel = self.requestServiceViewModel {
            requestViewModel.selected(zone: zone)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func showDays(availability: WeeklyAvailability?) {}
    func selected(weeklyAvailability: WeeklyAvailability) { }
    
    func search(servicesWithRequest request: RequestServiceRequest) {
        loadServices(request: request)
    }
    
    func serviceRequested() {
        parentDelegate.returnMain()
    }
}
