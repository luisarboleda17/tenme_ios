//
//  SignUpViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/4/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol CreditCardFormViewModelProtocol {
    init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: CreditCardFormControllerProtocol)
    
    func set(name: String, number: Int, expirationMonth: Int, expirationYear: Int, cvv: Int)
}

class CreditCardFormViewModel: CreditCardFormViewModelProtocol {
    internal var navDelegate: AppCoordinatorProtocol!
    internal var viewDelegate: CreditCardFormControllerProtocol!
    
    required init(
        _ navDelegate: AppCoordinatorProtocol,
        viewDelegate: CreditCardFormControllerProtocol) {
        
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    // MARK: - View model methods
    
    func set(name: String, number: Int, expirationMonth: Int, expirationYear: Int, cvv: Int) {
        let request = CreditCardRequest(
            name: name,
            number: number,
            expirationMonth: expirationMonth,
            expirationYear: expirationYear,
            cvv: cvv
        )
        
        print(request.toDict())
        
        viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.PaymentMethods.creditCards,
                    method: .post,
                    parameters: request.toDict(),
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
                                            title: "Tarjeta de crédito creada",
                                            message: "Se creó correctamente su tarjeta de crédito",
                                            completion: { _ in
                                                // Inform coordinator that user was updated
                                                self.navDelegate.returnMain()
                                            }
                                        )
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error creando tarjeta de crédito", message: "\(error)")
                                    }
                            }
                            )
                    }
                )
        }
        )
    }
}

