//
//  PostServiceCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol PostServiceCoordinatorProtocol: Coordinator {
    var parentDelegate: AppCoordinatorProtocol! { get set }
    var navigationController: UINavigationController! { get set }
    
    init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol)
    
    func start()
    func showCategories()
    func showZones()
    func showDays()
    func selected(category: Category)
    func selected(zone: Zone)
    func selected(weeklyAvailability: WeeklyAvailability)
}

class PostServiceCoordinator: PostServiceCoordinatorProtocol {
    internal let TAG = "POST SERVICE COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    internal var offerServiceViewModel: OfferServiceViewModel?
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    func start() {
        loadOfferService()
    }
    
    func showCategories() {
        loadCategoryView()
    }
    
    func showZones() {
        loadZoneView()
    }
    
    func showDays() {
        loadDayView()
    }
    
    func selected(category: Category) {
        if let offerViewModel = self.offerServiceViewModel {
            offerViewModel.selected(category: category)
            navigationController.popViewController(animated: true)
        }
    }
    
    func selected(zone: Zone) {
        if let offerViewModel = self.offerServiceViewModel {
            offerViewModel.selected(zone: zone)
            navigationController.popViewController(animated: true)
        }
    }
    
    func selected(weeklyAvailability: WeeklyAvailability) {
        if let offerViewModel = self.offerServiceViewModel {
            offerViewModel.selected(weeklyAvailability: weeklyAvailability)
        }
    }
}
