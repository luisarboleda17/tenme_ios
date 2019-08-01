//
//  RequestCreditsCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/14/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol PaymentMethodSelectionProtocol {
    func selected(paymentMethod: PaymentMethod?)
}

protocol RechargeCoordinatorProtocol: Coordinator {
    var parentDelegate: AppCoordinatorProtocol! { get set }
    var navigationController: UINavigationController! { get set }
    
    init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol)
    
    func start()
    func recharge()
    func requestCredits()
    
    func showPaymentMethods(showService: Bool)
    func selected(paymentMethod: PaymentMethod?)
    
    func creditsRequested()
    func accountRecharged()
}

class RechargeCoordinator: RechargeCoordinatorProtocol {
    internal let TAG = "RECHARGE COORDINATOR"
    internal var parentDelegate: AppCoordinatorProtocol!
    internal var navigationController: UINavigationController!
    
    internal var paymentMethodViewModel: PaymentMethodSelectionProtocol?
    
    required init(_ navigationController: UINavigationController, parentDelegate: AppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentDelegate = parentDelegate
    }
    
    func start() {
        loadRechargeTypeView()
    }
    
    func recharge() {
        loadRechargeView()
    }
    
    func requestCredits() {
        loadRequestCreditsView()
    }
    
    func showPaymentMethods(showService: Bool) {
        loadPaymentMethodView(showService: showService)
    }
    func selected(paymentMethod: PaymentMethod?) {
        if let viewModel = self.paymentMethodViewModel {
            viewModel.selected(paymentMethod: paymentMethod)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func creditsRequested() {
        parentDelegate.returnMain()
    }
    
    func accountRecharged() {
        parentDelegate.returnMain()
    }
}
