//
//  RechargeCreditsViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/28/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class RechargeCreditsViewModel: RequestCreditsViewModelProtocol, PaymentMethodSelectionProtocol {
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
        return "Recarga"
    }
    
    func getMainButtonTitle() -> String {
        return "Recargar"
    }
    
    func isCreditRequest() -> Bool {
        return false
    }
    
    func showPaymentMethods() {
        navDelegate.showPaymentMethods(showService: false)
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
            "isCredit": false
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
