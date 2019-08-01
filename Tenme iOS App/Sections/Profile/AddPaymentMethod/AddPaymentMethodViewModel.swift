//
//  AddPaymentMethodViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

protocol AddPaymentMethodViewModelProtocol {
    init(navDelegate: AppCoordinatorProtocol)
    
    func addCreditCard()
    func addBankAccount()
}

class AddPaymentMethodViewModel: AddPaymentMethodViewModelProtocol {
    internal var navDelegate: AppCoordinatorProtocol!
    
    required init(navDelegate: AppCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func addCreditCard() {
        navDelegate.addCreditCard()
    }
    
    func addBankAccount() {
        navDelegate.addBankAccount()
    }
}
