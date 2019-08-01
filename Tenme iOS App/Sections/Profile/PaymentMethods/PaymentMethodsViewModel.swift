//
//  WorkersViewModel.swift
//  Tenme iOS App
//
//  Created by Luis Arboleda on 7/7/19.
//  Copyright © 2019 Tenme. All rights reserved.
//

import Foundation
import Alamofire

protocol PaymentMethodsViewModelProtocol {
    init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: PaymentMethodsControllerProtocol)
    
    func getMethodsNumber() -> Int
    func getPaymentMethod(atIndex index: Int) -> PaymentMethod
    func selected(methodAtIndex index: Int)
    func viewDidLoad()
    func newMethod()
}

class PaymentMethodsViewModel: PaymentMethodsViewModelProtocol {
    internal var viewDelegate: PaymentMethodsControllerProtocol!
    internal var navDelegate: AppCoordinatorProtocol!
    
    private var methods: [PaymentMethod] = []
    
    required init(_ navDelegate: AppCoordinatorProtocol, viewDelegate: PaymentMethodsControllerProtocol) {
        self.navDelegate = navDelegate
        self.viewDelegate = viewDelegate
    }
    
    func viewDidLoad() {
        getMethods()
    }
    
    private func getMethods() {
        
        self.viewDelegate.showLoading(
            loading: true,
            completion: {
                Alamofire.request(
                    API.PaymentMethods.collectionBase,
                    headers: [
                        "Authorization": "Bearer " + (UserSession.current.token ?? "")
                    ]
                    ).validate().responseJSON(
                        queue: DispatchQueue.backgroundQueue,
                        completionHandler: { response in
                            self.viewDelegate.showLoading(
                                loading: false,
                                completion: {
                                    switch response.result {
                                    case .success(let data):
                                        if let methods = data as? [[String:Any]] {
                                            self.methods = methods.compactMap({ method in
                                                if let type = method["type"] as? String {
                                                    if type == "card" {
                                                        if let last4 = method["cardLast4"] as? Int,
                                                            let name = method["cardholderName"] as? String,
                                                            let id = method["id"] as? String {
                                                            return CreditCard(id: id, cardLast4: last4, cardholderName: name)
                                                        } else {
                                                            return nil
                                                        }
                                                    } else if type == "account" {
                                                        if let id = method["id"] as? String,
                                                            let bankId = method["bankId"] as? String,
                                                            let type = method["accountType"] as? String,
                                                            let accountType = BankAccount.AccountType(rawValue: type),
                                                            let number = method["accountNumber"] as? Int,
                                                            let bank = method["bank"] as? [String:Any],
                                                            let bankName = bank["name"] as? String {
                                                            
                                                            return BankAccount(id: id, bankId: bankId, type: accountType, number: number, bankName: bankName)
                                                        } else {
                                                            return nil
                                                        }
                                                    } else {
                                                        return nil
                                                    }
                                                } else {
                                                    return nil
                                                }
                                            })
                                            self.viewDelegate.refreshItems()
                                        } else {
                                            self.viewDelegate.showAlert(title: "Error obteniendo métodos de pago", message: "Ha ocurrido un error desconocido")
                                        }
                                    case .failure(let error):
                                        self.viewDelegate.showAlert(title: "Error obteniendo métodos de pago", message: "\(error)")
                                    }
                            }
                            )
                    }
                )
            }
        )
    }
    
    // MARK: - View model methods
    
    func getMethodsNumber() -> Int {
        return self.methods.count
    }
    
    func getPaymentMethod(atIndex index: Int) -> PaymentMethod {
        return self.methods[index]
    }
    
    func selected(methodAtIndex index: Int) { }
    
    func newMethod() {
        navDelegate.addPaymentMethod()
    }
}
