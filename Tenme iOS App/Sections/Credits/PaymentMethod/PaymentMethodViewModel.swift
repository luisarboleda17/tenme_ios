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
    func getPaymentMethod(forIndex index: Int) -> CreditRequest.PaymentMethod
    func getMethodsNumber() -> Int
    func select(methodAtIndex index: Int)
}

class PaymentMethodViewModel: PaymentMethodViewModelProtocol {
    internal var navDelegate: RequestCreditsCoordinatorProtocol!
    
    private var methods: [CreditRequest.PaymentMethod] = [
        CreditRequest.PaymentMethod(key: "services", name: "Servicios"),
        CreditRequest.PaymentMethod(key: "bank_account", name: "Cuenta bancaria")
    ]
    
    required init(_ navDelegate: RequestCreditsCoordinatorProtocol) {
        self.navDelegate = navDelegate
    }
    
    func getPaymentMethod(forIndex index: Int) -> CreditRequest.PaymentMethod {
        return methods[index]
    }
    
    func getMethodsNumber() -> Int {
        return methods.count
    }
    
    func select(methodAtIndex index: Int) {
        navDelegate.select(paymentType: methods[index])
    }
}
