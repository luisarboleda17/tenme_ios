//
//  AppCoordinator.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    init(_ navigationController: UINavigationController)
    
    func start()
    func appLoaded()
    func userAuthenticated()
    func loadOfferService()
    func loadRequestService()
    func loadRecharge()
    func loadHistories()
    func updateProfile()
    func showProfile(balance: Decimal)
    func showPaymentMethods()
    func addCreditCard()
    func addBankAccount()
    func addPaymentMethod()
    func returnMain()
    func returnAuth()
    func showBanks()
    func showAccountTypes()
    func selected(type: BankAccount.AccountType)
    func selected(bank: Bank)
}

class AppCoordinator: AppCoordinatorProtocol {
    internal let TAG = "APP COORDINATOR"
    internal var navigationController: UINavigationController {
        didSet { self.configureNavigationBar() }
    }
    
    internal var mainViewController: MainController?
    internal var bankAccountFormViewModel: BankAccountFormViewModelProtocol?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func configureNavigationBar() {
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        loadSplashScreen()
    }
    
    func appLoaded() {
        if (UserSession.current.isOpen) {
            loadMainView()
        } else {
            loadAuthentication()
        }
    }
    
    func userAuthenticated() {
        loadMainView()
    }
    
    func loadOfferService() {
        loadPostService()
    }
    
    func loadRequestService() {
        loadRequestServiceView()
    }
    
    func loadRecharge() {
        loadRechargeCoordinator()
    }
    
    func loadHistories() {
        loadHistory()
    }
    
    func returnMain() {
        returnMainView()
    }
    
    func returnAuth() {
        loadAuthentication()
    }
    
    func updateProfile() {
        loadUpdateProfile()
    }
    
    func showProfile(balance: Decimal) {
        loadProfileView(balance: balance)
    }
    
    func showPaymentMethods() {
        loadPaymentMethodsView()
    }
    
    func addCreditCard() {
        loadAddCreditCard()
    }
    
    func addBankAccount() {
        loadBankForm()
    }
    
    func showBanks() {
        loadBankView()
    }
    
    func showAccountTypes() {
        loadAccountTypeView()
    }
    
    func selected(type: BankAccount.AccountType) {
        if let bankAccountFormViewModel = self.bankAccountFormViewModel {
            bankAccountFormViewModel.set(accountType: type)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func selected(bank: Bank) {
        if let bankAccountFormViewModel = self.bankAccountFormViewModel {
            bankAccountFormViewModel.set(bank: bank)
            OperationQueue.main.addOperation {
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    func addPaymentMethod() {
        loadAddPaymentTypes()
    }
}
