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
                categoryController.bind(CategoryViewModel(self))
                self.navigationController.show(categoryController, sender: self)
            }
        }
    }
    
    internal func loadOfferService(category: Category) {
        OperationQueue.main.addOperation {
            if let offerServiceController = ViewLoader.load(OfferServiceController.self, xibName: XIBS.Controllers.offerService) {
                offerServiceController.bind(OfferServiceViewModel(self, category: category))
                self.navigationController.show(offerServiceController, sender: self)
            }
        }
    }
}
