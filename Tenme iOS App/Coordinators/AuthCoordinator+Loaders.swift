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
                signInController.bind(SignInViewModel(self, viewDelegate: signInController))
                self.navigationController.show(signInController, sender: self)
            }
        }
    }
    
    internal func loadPassword(phone: Int) {
        OperationQueue.main.addOperation {
            if let passwordController = ViewLoader.load(PasswordController.self, xibName: XIBS.Controllers.password) {
                passwordController.bind(PasswordViewModel(self, phone: phone))
                self.navigationController.show(passwordController, sender: self)
            }
        }
    }
    
    internal func loadSignUp(countryCode: Int?, phoneNumber: Int?) {
        OperationQueue.main.addOperation {
            if let signUpController = ViewLoader.load(SignUpController.self, xibName: XIBS.Controllers.signUp) {
                signUpController.bind(SignUpViewModel(self, viewDelegate: signUpController, countryCode: countryCode, phoneNumber: phoneNumber))
                self.navigationController.show(signUpController, sender: self)
            }
        }
    }
    
    internal func loadBankInfo(request: SignUpRequest) {
        OperationQueue.main.addOperation {
            if let bankInfoController = ViewLoader.load(BankInfoController.self, xibName: XIBS.Controllers.bankInfo) {
                bankInfoController.bind(BankInfoViewModel(self, request: request))
                self.navigationController.show(bankInfoController, sender: self)
            }
        }
    }
}
