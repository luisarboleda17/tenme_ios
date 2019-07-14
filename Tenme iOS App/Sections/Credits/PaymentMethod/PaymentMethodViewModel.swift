//
//  CategoryViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol PaymentMethodViewModelProtocol {
    init(_ navDelegate: RequestCreditsCoordinatorProtocol)
    func getPaymentMethod(forIndex index: Int) -> Credit.PaymentMethod
    func getMethodsNumber() -> Int
    func select(methodAtIndex index: Int)
}

class PaymentMethodViewModel: PaymentMethodViewModelProtocol {
    internal var navDelegate: RequestCreditsCoordinatorProtocol!
    
    private var methods: [Credit.PaymentMethod] = [
        Credit.PaymentMethod(key: "services", name: "Servicios"),
        Credit.PaymentMethod(key: "bank_account", name: "Cuenta bancaria")
    ]
    
    required init(_ navDelegate: RequestCreditsCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func getPaymentMethod(forIndex index: Int) -> Credit.PaymentMethod {
        return methods[index]
    }
    
    func getMethodsNumber() -> Int {
        return methods.count
    }
    
    func select(methodAtIndex index: Int) {
        navDelegate.select(paymentType: methods[index])
    }
}
