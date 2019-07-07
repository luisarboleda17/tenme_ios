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
}

class OfferServiceViewModel: OfferServiceViewModelProtocol {
    internal var navDelegate: PostServiceCoordinatorProtocol!
    internal var viewDelegate: OfferServiceControllerProtocol!
    
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
        viewDelegate.updated(categoryName: category.name)
    }
}
