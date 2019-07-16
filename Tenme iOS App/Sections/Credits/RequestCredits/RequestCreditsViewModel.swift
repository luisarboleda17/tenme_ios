//
//  RequestCreditsViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/13/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol RequestCreditsViewModelProtocol {
    init(_ navDelegate: RequestCreditsCoordinatorProtocol, viewDelegate: RequestCreditsControllerProtocol)
    
    func selected(paymentMethod: Credit.PaymentMethod)
    func showPaymentMethods()
}

class RequestCreditsViewModel: RequestCreditsViewModelProtocol {
    
    private var navDelegate: RequestCreditsCoordinatorProtocol!
    private var viewDelegate: RequestCreditsControllerProtocol!
    
    required init(_ navDelegate: RequestCreditsCoordinatorProtocol, viewDelegate: RequestCreditsControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func selected(paymentMethod: Credit.PaymentMethod) {
        viewDelegate.update(paymentMethod: paymentMethod.name)
    }
    
    func showPaymentMethods() {
        navDelegate.showPaymentTypes()
    }
}
