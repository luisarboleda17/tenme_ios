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
    init(_ navDelegate: RechargeCoordinatorProtocol, viewDelegate: RequestCreditsControllerProtocol)
    
    func getTitle() -> String
    func getMainButtonTitle() -> String
    func isCreditRequest() -> Bool
    func showPaymentMethods()
    func request(amount: Decimal)
}

class RequestCreditsViewModel: RequestCreditsViewModelProtocol, PaymentMethodSelectionProtocol {
    private var navDelegate: RechargeCoordinatorProtocol!
    private var viewDelegate: RequestCreditsControllerProtocol!
    
    private var paymentMethodId: String?
    private var paymentSelected = false
    
    required init(_ navDelegate: RechargeCoordinatorProtocol, viewDelegate: RequestCreditsControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    // MARK: - View model methods
    
    func getTitle() -> String {
        return "Solicitud de créditos"
    }
    
    func getMainButtonTitle() -> String {
        return "Solicitar"
    }
    
    func isCreditRequest() -> Bool {
        return true
    }
    
    func showPaymentMethods() {
        navDelegate.showPaymentMethods(showService: true)
    }
    
    func selected(paymentMethod: PaymentMethod?) {
        self.paymentSelected = true
        self.paymentMethodId = paymentMethod?.getId()
        
        if let paymentMethod = paymentMethod {
            viewDelegate.update(paymentMethod: "\(paymentMethod.getInformation()) \(paymentMethod.getNumeration())")
        } else {
            viewDelegate.update(paymentMethod: "Servicios")
        }
    }
    
    func request(amount: Decimal) {
        var parameters: [String:Any] = [
            "amount": amount,
            "isCredit": true
        ]
        
        if let methodId = self.paymentMethodId {
            parameters["paymentMethod"] = methodId
        } else {
            guard paymentSelected else {
                self.viewDelegate.showAlert(title: "Información requerida", message: "Debe seleccionar un método de pago")
                return
            }
            parameters["payWithService"] = true
        }
        
        self.viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.Credit.request,
                    method: .post,
                    parameters: parameters,
                    encoding: JSONEncoding.default,
                    headers: [
                        "Authorization": "Bearer " + (UserSession.current.token ?? "")
                    ]
                    ).validate().responseData(
                        queue: DispatchQueue.backgroundQueue,
                        completionHandler: { response in
                            self.viewDelegate.showLoading(
                                loading: false,
                                completion: {
                                    switch response.result {
                                    case .success:
                                        self.viewDelegate.showAlert(
                                            title: "Crédito solicitado",
                                            message: "Puede ver información del crédito solicitado visualizando el Historial",
                                            completion: { _ in
                                                self.navDelegate.creditsRequested()
                                        }
                                        )
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error solicitando crédito", message: "\(error)")
                                    }
                            }
                            )
                    }
                )
        }
        )
    }
}
