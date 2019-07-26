//
//  AuthCoordinator+Loaders.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/2/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

extension AuthCoordinator {
    internal func loadSignIn() {
        OperationQueue.main.addOperation {
            if let signInController = ViewLoader.load(SignInController.self, xibName: XIBS.Controllers.signIn) {
                let viewModel = SignInViewModel(self, viewDelegate: signInController)
                
                self.countrySelectionViewModel = viewModel
                signInController.bind(viewModel)
                self.navigationController.show(signInController, sender: self)
            }
        }
    }
    
    internal func loadPassword(phone: Int) {
        OperationQueue.main.addOperation {
            if let passwordController = ViewLoader.load(PasswordController.self, xibName: XIBS.Controllers.password) {
                passwordController.bind(PasswordViewModel(self, viewDelegate: passwordController, phone: phone))
                self.navigationController.show(passwordController, sender: self)
            }
        }
    }
    
    internal func loadSignUp(countryCode: Int?, phoneNumber: Int?, facebookUser: FacebookUser?) {
        OperationQueue.main.addOperation {
            if let signUpController = ViewLoader.load(SignUpController.self, xibName: XIBS.Controllers.signUp) {
                let viewModel = SignUpViewModel(self, viewDelegate: signUpController, countryCode: countryCode, phoneNumber: phoneNumber, facebookUser: facebookUser)
                self.countrySelectionViewModel = viewModel
                
                signUpController.bind(viewModel)
                self.navigationController.show(signUpController, sender: self)
            }
        }
    }
    
    internal func loadCountryCodeView() {
        OperationQueue.main.addOperation {
            if let countryController = ViewLoader.load(CountryCodeController.self, xibName: XIBS.Controllers.countryCode) {
                countryController.bind(CountryCodeViewModel(self, viewDelegate: countryController))
                self.navigationController.show(countryController, sender: self)
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
    
    internal func loadBankInfo(request: SignUpRequest) {
        OperationQueue.main.addOperation {
            if let bankInfoController = ViewLoader.load(BankInfoController.self, xibName: XIBS.Controllers.bankInfo) {
                let viewModel = BankInfoViewModel(self, viewDelegate: bankInfoController, request: request)
                self.bankInfoViewModel = viewModel
                
                bankInfoController.bind(viewModel)
                self.navigationController.show(bankInfoController, sender: self)
            }
        }
    }
}
