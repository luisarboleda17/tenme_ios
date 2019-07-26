//
//  RequestCreditsCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol RequestCreditsCoordinatorProtocol: Coordinator {
    var parentDelegate: AppCoordinatorProtocol! { get set }
    var navigationController: UINavigationController! { get set }
    
    init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol)
    
    func start()
    func showPaymentTypes()
    func select(paymentType: CreditRequest.PaymentMethod)
    func creditsRequested()
}

class RequestCreditsCoordinator: RequestCreditsCoordinatorProtocol {
    internal let TAG = "REQUEST CREDITS COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    internal var requestCreditsViewModel: RequestCreditsViewModelProtocol?
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    func start() {
        loadRequestCredits()
    }
    
    func showPaymentTypes() {
        loadPaymentMethodView()
    }
    
    func select(paymentType: CreditRequest.PaymentMethod) {
        if let requestViewModel = self.requestCreditsViewModel {
            requestViewModel.selected(paymentMethod: paymentType)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func creditsRequested() {
        parentDelegate.returnMain()
    }
}
