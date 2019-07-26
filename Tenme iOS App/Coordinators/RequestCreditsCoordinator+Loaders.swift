//
//  RequestCreditsCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension RequestCreditsCoordinator {
    internal func loadRequestCredits() {
        OperationQueue.main.addOperation {
            if let requestCreditsController = ViewLoader.load(RequestCreditsController.self, xibName: XIBS.Controllers.requestCredits) {
                let requestViewModel = RequestCreditsViewModel(self, viewDelegate: requestCreditsController)
                
                self.requestCreditsViewModel = requestViewModel
                requestCreditsController.bind(requestViewModel)
                self.navigationController.show(requestCreditsController, sender: self)
            }
        }
    }
    
    internal func loadPaymentMethodView() {
        OperationQueue.main.addOperation {
            if let methodsController = ViewLoader.load(PaymentMethodController.self, xibName: XIBS.Controllers.paymentMethod) {
                methodsController.bind(PaymentMethodViewModel(self))
                self.navigationController.show(methodsController, sender: self)
            }
        }
    }
}
