//
//  AppCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/1/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension AppCoordinator {
    
    internal func loadSplashScreen() {
        OperationQueue.main.addOperation {
            if let splashController = ViewLoader.load(SplashController.self, xibName: XIBS.Controllers.splash) {
                splashController.bind(SplashViewModel(self))
                self.navigationController.show(splashController, sender: self)
            }
        }
    }
    
    internal func loadAuthentication() {
        let authCoordinator = AuthCoordinator(self.navigationController, parentDelegate: self)
        authCoordinator.start()
    }
    
    internal func loadMainView() {
        OperationQueue.main.addOperation {
            if let mainController = ViewLoader.load(MainController.self, xibName: XIBS.Controllers.main) {
                
                self.mainViewController = mainController
                
                mainController.bind(MainViewModel(self, viewDelegate: mainController))
                self.navigationController.show(mainController, sender: self)
            }
        }
    }
    
    internal func loadPostService() {
        let postServiceCoordinator = PostServiceCoordinator(navigationController, parentDelegate: self)
        postServiceCoordinator.start()
    }
    
    internal func loadRequestServiceView() {
        let requestServiceCoordinator = RequestServiceCoordinator(navigationController, parentDelegate: self)
        requestServiceCoordinator.start()
    }
    
    internal func loadRequestCreditsView() {
        let requestCreditsCoordinator = RequestCreditsCoordinator(navigationController, parentDelegate: self)
        requestCreditsCoordinator.start()
    }
    
    internal func loadHistory() {
        OperationQueue.main.addOperation {
            if let historyController = ViewLoader.load(HistoryController.self, xibName: XIBS.Controllers.history) {
                
                historyController.bind(HistoryViewModel(self, viewDelegate: historyController))
                self.navigationController.show(historyController, sender: self)
            }
        }
    }
    
    internal func loadProfileView(balance: Decimal) {
        OperationQueue.main.addOperation {
            if let profileController = ViewLoader.load(ProfileViewController.self, xibName: XIBS.Controllers.profile) {
                
                profileController.bind(ProfileViewModel(self, viewDelegate: profileController, balance: balance))
                self.navigationController.show(profileController, sender: self)
            }
        }
    }
    
    internal func loadPaymentMethodsView() {
        OperationQueue.main.addOperation {
            if let methodsController = ViewLoader.load(PaymentMethodsController.self, xibName: XIBS.Controllers.paymentMethods) {
                
                methodsController.bind(PaymentMethodsViewModel(self, viewDelegate: methodsController))
                self.navigationController.show(methodsController, sender: self)
            }
        }
    }
    
    internal func loadUpdateProfile() {
        OperationQueue.main.addOperation {
            if let profileController = ViewLoader.load(UpdateProfileController.self, xibName: XIBS.Controllers.updateProfile) {
                
                profileController.bind(UpdateProfileViewModel(self, viewDelegate: profileController))
                self.navigationController.show(profileController, sender: self)
            }
        }
    }
    
    internal func loadAddCreditCard() {
        OperationQueue.main.addOperation {
            if let creditcardController = ViewLoader.load(CreditCardFormController.self, xibName: XIBS.Controllers.creditCardForm) {
                
                creditcardController.bind(CreditCardFormViewModel(self, viewDelegate: creditcardController))
                self.navigationController.show(creditcardController, sender: self)
            }
        }
    }
    
    func returnMainView() {
        OperationQueue.main.addOperation {
            if let mainView = self.mainViewController {
                self.navigationController.popToViewController(mainView, animated: true)
            }
        }
    }
    
    internal func loadAccountTypeView() {
        OperationQueue.main.addOperation {
            if let accountTypeController = ViewLoader.load(AccountTypeController.self, xibName: XIBS.Controllers.accountType) {
                accountTypeController.bind(AccountTypeViewModel(self))
                self.navigationController.show(accountTypeController, sender: self)
            }
        }
    }
    
    internal func loadBankView() {
        OperationQueue.main.addOperation {
            if let bankController = ViewLoader.load(BankController.self, xibName: XIBS.Controllers.bank) {
                bankController.bind(BankViewModel(self, viewDelegate: bankController))
                self.navigationController.show(bankController, sender: self)
            }
        }
    }
    
    internal func loadBankForm() {
        OperationQueue.main.addOperation {
            if let bankFormController = ViewLoader.load(BankAccountFormController.self, xibName: XIBS.Controllers.bankAccountForm) {
                let viewModel = BankAccountFormViewModel(self, viewDelegate: bankFormController)
                self.bankAccountFormViewModel = viewModel
                
                bankFormController.bind(viewModel)
                self.navigationController.show(bankFormController, sender: self)
            }
        }
    }
    
    internal func loadAddPaymentTypes() {
        OperationQueue.main.addOperation {
            if let addPaymentController = ViewLoader.load(AddPaymentMethodController.self, xibName: XIBS.Controllers.addPaymentMethod) {
                addPaymentController.bind(AddPaymentMethodViewModel(navDelegate: self))
                self.navigationController.show(addPaymentController, sender: self)
            }
        }
    }
}
