//
//  RequestCreditsCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension RechargeCoordinator {
    internal func loadRechargeTypeView() {
        OperationQueue.main.addOperation {
            if let rechargeTypeController = ViewLoader.load(RechargeTypeController.self, xibName: XIBS.Controllers.rechargeType) {
                rechargeTypeController.bind(RechargeTypeViewModel(navDelegate: self))
                self.navigationController.show(rechargeTypeController, sender: self)
            }
        }
    }
    
    internal func loadRequestCreditsView() {
        OperationQueue.main.addOperation {
            if let requestCreditsController = ViewLoader.load(RequestCreditsController.self, xibName: XIBS.Controllers.requestCredits) {
                let requestViewModel = RequestCreditsViewModel(self, viewDelegate: requestCreditsController)
                
                self.paymentMethodViewModel = requestViewModel
                requestCreditsController.bind(requestViewModel)
                self.navigationController.show(requestCreditsController, sender: self)
            }
        }
    }
    
    internal func loadRechargeView() {
        OperationQueue.main.addOperation {
            if let rechargeCreditsController = ViewLoader.load(RequestCreditsController.self, xibName: XIBS.Controllers.requestCredits) {
                let requestViewModel = RechargeCreditsViewModel(self, viewDelegate: rechargeCreditsController)
                
                self.paymentMethodViewModel = requestViewModel
                rechargeCreditsController.bind(requestViewModel)
                self.navigationController.show(rechargeCreditsController, sender: self)
            }
        }
    }
    
    internal func loadPaymentMethodView(showService: Bool) {
        OperationQueue.main.addOperation {
            if let methodsController = ViewLoader.load(PaymentMethodController.self, xibName: XIBS.Controllers.paymentMethod) {
                methodsController.bind(PaymentMethodViewModel(self, viewDelegate: methodsController, showServiceOption: showService))
                self.navigationController.show(methodsController, sender: self)
            }
        }
    }
}
