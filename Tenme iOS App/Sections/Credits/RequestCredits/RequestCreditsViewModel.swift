//
//  RequestCreditsViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/13/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestCreditsViewModelProtocol {
    init(_ navDelegate: RequestCreditsCoordinatorProtocol, viewDelegate: RequestCreditsControllerProtocol)
    
    func selected(paymentMethod: Credit.PaymentMethod)
    func showPaymentMethods()
    func request(amount: Decimal)
}

class RequestCreditsViewModel: RequestCreditsViewModelProtocol {
    
    private var navDelegate: RequestCreditsCoordinatorProtocol!
    private var viewDelegate: RequestCreditsControllerProtocol!
    
    private var paymentMethod: Credit.PaymentMethod!
    
    required init(_ navDelegate: RequestCreditsCoordinatorProtocol, viewDelegate: RequestCreditsControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    // MARK: - View model methods
    
    func selected(paymentMethod: Credit.PaymentMethod) {
        self.paymentMethod = paymentMethod
        viewDelegate.update(paymentMethod: paymentMethod.name)
    }
    
    func showPaymentMethods() {
        navDelegate.showPaymentTypes()
    }
    
    func request(amount: Decimal) {
        let credit = Credit(amount: amount, paymentMethod: self.paymentMethod)
        
        Alamofire.request(
            API.Credit.request,
            method: .post,
            parameters: credit.toDict(),
            encoding: JSONEncoding.default,
            headers: [
                "Authorization": "Bearer " + (UserSession.current.token ?? "")
            ]
        ).validate().responseData(
            queue: DispatchQueue.backgroundQueue,
            completionHandler: { response in
                switch response.result {
                case .success:
                    print("Success")
                    self.navDelegate.creditsRequested()
                case .failure(let error):
                    print("Error \(error)")
                }
            }
        )
    }
}
